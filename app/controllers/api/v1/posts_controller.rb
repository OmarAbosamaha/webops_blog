module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: %i(destroy update)

      def index
        posts = Post.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded posts', data:posts},status: :ok
      end

      def show
        post = Post.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded post', data:post},status: :ok
      end

      def create
        post = @current_user.posts.new(post_params.except(:tags_attributes))
        if post_params.has_key?(:tags_attributes)
          ActiveRecord::Base.transaction do
            if post.save!
              assign_tags(post)
              DeleteOldPostsJob.perform_later(24.hours.from_now,post.id)
              render json: { status: 'SUCCESS', message:'saved post', data:post }, status: :ok
            else
              render json: { status: 'ERROR', message:'Post not saved', data: post.errors }, status: :unprocessable_entity
            end
          end
        else
          render json: {status: 'ERROR', message:'Post must have at least one tag', data:post.errors}, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
      end

      def update
        if @post.update(post_params)
          render json: {status: 'SUCCESS', message:'Updated post', data:@post},status: :ok
        else
          render json: {status: 'ERROR', message:'Post not updated', data:@post.errors},status: :unprocessable_entity
        end
      end

      private

      def set_post
        @post = @current_user.posts.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body, tags_attributes: [:body])
      end

      def assign_tags(post)
        post_params[:tags_attributes].each do |tag_params|
          tag = Tag.find_or_create_by!(body: tag_params[:body])
          post.post_tags.find_or_create_by!(tag_id: tag.id)
        end
      end

    end
  end
end
