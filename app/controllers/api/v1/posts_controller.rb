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
        #TODO create new tags first then associate them with the current post
        post = @current_user.posts.new(post_params)
        if (post.save)
          render json: {status: 'SUCCESS', message:'saved post', data:post},status: :ok
        else
          render json: {status: 'ERROR', message:'Post not saved', data:post.errors},status: :unprocessable_entity
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
        params.require(:post).permit(:title, :body, tags_attributes:[:body =>[]])
      end

    end
  end
end
