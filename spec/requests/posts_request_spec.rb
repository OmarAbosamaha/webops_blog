require 'rails_helper'

RSpec.describe "Posts", type: :request do
# setting the end point for testing
post_params =  {
  title: 'title',
  body: 'body',
  tags_attributes: [{body: 'tag'}]
  }
  context 'Put #update and #delete' do
      let (:user) {create(:user)}
      it 'user should update his own post' do
        post = user.posts.new(post_params)
        post.save
        jwt = Auth.issue({user: user.id})
        headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
        put "/api/v1/posts/#{post.id}", :params => {post:{body: 'updated body'}}, :headers => headers
        expect(response.status).to eq(200)
      end

      it 'user should delete his own post' do
        post = user.posts.new(post_params)
        post.save
        jwt = Auth.issue({user: user.id})
        headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
        delete "/api/v1/posts/#{post.id}", :headers => headers
        expect(response.status).to eq(200)
    end
  end
end
