class DeleteOldPostsJob < ApplicationJob
  queue_as :default

  def perform(id)
    # Do something later
    post = Post.where(id:id)
    post.comments.destroy
    post.destroy
    # render json: {status: 'SUCCESS', message:'Deleted old post', data:post},status: :ok
  end
end
