require 'rails_helper'

RSpec.describe Post, type: :model do
  context 'validation tests' do
    it 'ensures title presence' do
      post = Post.new(body: 'post body').save
      expect(post).to eq(false)
    end

    it 'ensures body presence' do
      post = Post.new(title: 'post title').save
      expect(post).to eq(false)
    end

    it 'ensures title can not be empty string' do
      post = Post.new(title: '', body: 'bodyyy').save
      expect(post).to eq(false)
    end

    it 'ensures body can not be empty string' do
      post = Post.new(title: 'post title', body: '').save
      expect(post).to eq(false)
    end

  end
end
