module API
  module V1
    class PostsController < ApplicationRecord

      def index
        comments = Comment.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded comments', data:comments},status: :ok
      end

      def show
        comment = Comment.find(params[:id])
        render json: {status: 'SUCCESS', message:'Loaded comment', data:comment},status: :ok
      end

      def create
        comment = current_user.comments.new(comment_params)
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
          params.require(:comment).permit(:body, post_attributes: [:post_id])
        end
      end
    end
  end
end
