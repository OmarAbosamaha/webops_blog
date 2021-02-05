module Api
  module V1
    class PostsController < ApplicationController

      def index
        posts = Post.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded posts', data:posts},status: :ok
      end

      def show
        post = Post.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded post', data:post},status: :ok
      end

      def create
        post = @current_user.posts.new(post_params)
        #make sure we have at least one tag in body
        if post_params.has_key?(:tags_attributes)
          byebug
          if post.save
            DeleteOldPostsJob.perform_later(24.hours.from_now,post.id)
            render json: {status: 'SUCCESS', message:'saved post', data:post},status: :ok
          else
            render json: {status: 'ERROR', message:'Post not saved', data:post.errors},status: :unprocessable_entity
          end
        else
          render json: {status: 'ERROR', message:'Post must have at least one tag', data:post.errors},status: :unprocessable_entity
        end
      end

      def destroy
        post = @current_user.posts.find (params[:id])
        post.comments.destroy
        post.destroy
        render json: {status: 'SUCCESS', message:'Deleted post', data:post},status: :ok
      end

      def update
        post = @current_user.posts.find(params[:id])
        if post.update_attributes(post_params)
          render json: {status: 'SUCCESS', message:'Updated post', data:post},status: :ok
        else
          render json: {status: 'ERROR', message:'Post not updated', data:post.errors},status: :unprocessable_entity
        end
      end

      private

      def post_params
        params.require(:post).permit(:title, :body, tags_attributes: [:body])
      end

    end
  end
end
