module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_post

      def index
        tags = Tag.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded tags', data:tags},status: :ok
      end

      def update
        tag = @post.tags.find(params[:id])
        if tag.update_attributes(tag_params)
          render json: {status: 'SUCCESS', message:'Updated tag', data:tag},status: :ok
        else
          render json: {status: 'ERROR', message:'Tag not updated', data:tag.errors},status: :unprocessable_entity
        end
      end

      private
        def tag_params
          params.require(:tag).permit(:body)
        end

        def set_post
          @post = @current_user.posts.find(params[:post_id])
        end
    end
  end
end
