module Api
  module V1
    class CommentsController < ApplicationController
      before_action :set_post
      def index
        comments = @post.comments.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded comments', data:comments},status: :ok
      end

      def show
        comment = @post.comments.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded comment', data:comment},status: :ok
      end

      def create
        comment = current_user.comments.new(comment_params.merge(post_id: @post.id))
        if (comment.save)
          render json: {status: 'SUCCESS', message:'saved comment', data:comment},status: :ok
        else
          render json: {status: 'ERROR', message:'Comment not saved', data:comment.errors},status: :unprocessable_entity
        end
      end

      def destroy
        comment = current_user.comments.find (params[:id])
        comment.destroy
        render json: {status: 'SUCCESS', message:'Deleted comment', data:comment},status: :ok
      end

      def update
        comment = current_user.comments.find(params[:id])
        if comments.update_attributes(comment_params)
          render json: {status: 'SUCCESS', message:'Updated comment', data:comment},status: :ok
        else
          render json: {status: 'ERROR', message:'Comment not updated', data:comment.errors},status: :unprocessable_entity
        end
      end

      private
        def comment_params
          params.require(:comment).permit(:body)
        end

        def set_post
          @post = Post.find(params[:post_id])
        end
    end
  end
end
