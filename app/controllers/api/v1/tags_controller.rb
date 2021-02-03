module Api
  module V1
    class TagsController < ApplicationController
      before_action :set_post

      def update
        tag = @post.tags.find(params[:id])
        if tags.update_attributes(tag_params)
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
          @post = Post.find(params[:post_id])
        end
    end
  end
end
