require 'rails_helper'

RSpec.describe "Comments", type: :request do
  comment_params ={
    comment:{
    body: "Tarzan commenting"}
  }

  post_params =  {
    title: 'title',
    body: 'body',
    tags_attributes: [{body: 'tag'}]
    }

  context 'User handling his comments' do
    let (:user) {create(:user)}
    let (:user2) {create(:user)}

    it 'should create new comment on any post' do
      #user making a post
      post = user.posts.new(post_params)
      post.save
      jwt = Auth.issue({user: user2.id})
      headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
      # another user commenting
      post "/api/v1/posts/#{post.id}/comments", :params => comment_params, :headers => headers
      expect(response.status).to eq(200)
    end

    it 'should update a comment' do
      # #user making a post and commenting on it
      # post = user.posts.new(post_params)
      # post.save
      # comment = user.comments.new({body: 'comment body', post_id: post.id})
      # jwt = Auth.issue({user: user.id})
      # headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
      # put "/api/v1/posts/#{post.id}/comments/#{comment.id}", :params => {comment:{body: 'updated comment body'}}, :headers => headers
      # expect(response.status).to eq(200)
    end

    it 'user can delete their comment' do
      # #user making a post and commenting on it
      # post = user.posts.new(post_params)
      # post.save
      # comment = user.comments.new({body: 'comment body', post_id: post.id})
      # jwt = Auth.issue({user: user.id})
      # headers = { "ACCEPT" => "application/json", 'Authorization': "Bearer #{jwt}"}
      # delete "/api/v1/posts/#{post.id}/comments/#{comment.id}", :headers => headers
      # expect(response.status).to eq(200)
    end
  end
end
