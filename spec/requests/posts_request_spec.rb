require 'rails_helper'

RSpec.describe "Posts", type: :request do
# setting the end point for testing
post_params =  {
  title: 'title',
  body: 'body',
  tags_attributes: [{body: 'tag'}]
  }
  context 'User handling his posts' do
      let (:user) {create(:user)}
      let (:user2) {create(:user)}
      let(:post) { create(:post, post_params.merge(user: user))}

      it 'user should update his own post' do
        jwt = Auth.issue({user: user.id})
        headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
        put "/api/v1/posts/#{post.id}", :params => {post:{body: 'updated body'}}, :headers => headers
        expect(response.status).to eq(200)
      end

      it 'user should delete his own post' do
        before_count = Post.count
        jwt = Auth.issue({user: user.id})
        headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
        delete "/api/v1/posts/#{post.id}", :headers => headers
        expect(Post.count).to eq(before_count-1)
      end

      it 'user should not delete a post that is not his' do
        before_count = Post.count
        jwt = Auth.issue({user: user2.id})
        headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
        delete "/api/v1/posts/#{post.id}", :headers => headers
        expect(Post.count).to eq(before_count)
      end

      it 'user should not update a post that is not his' do
        jwt = Auth.issue({user: user2.id})
        headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
        put "/api/v1/posts/#{post.id}", :params => {post:{body: 'updated body'}}, :headers => headers
        expect(response.status).to eq(404)
      end
  end
end
