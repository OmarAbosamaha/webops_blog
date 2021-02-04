require 'rails_helper'

RSpec.describe User, type: :model do
  context 'validation tests' do
    it 'ensures username presence' do
      user = User.new(email: 'testmail@gmail.com', password:'12345678').save
      expect(user).to eq(false)
    end

    it 'ensures email presence' do
      user = User.new(username: 'testusername', password:'12345678').save
      expect(user).to eq(false)
    end

    it 'ensures email can not be empty string' do
      user = User.new(email: '', password:'12345678', username: 'test').save
      expect(user).to eq(false)
    end

    it 'ensures email is unique' do
      user1 = User.new(email: 'email@gmail.com', password:'12345678', username: 'test').save
      user2 = User.new(email: 'email@gmail.com', password:'12345678', username: 'test2').save
      expect(user2).to eq(false)
    end

    it 'ensures username is unique' do
      user1 = User.new(email: 'email@gmail.com', password:'12345678', username: 'test').save
      user2 = User.new(email: 'email2@gmail.com', password:'12345678', username: 'test').save
      expect(user2).to eq(false)
    end

    it 'ensures email has email format' do
      user = User.new(email: 'email.hamada', password:'12345678', username: 'test').save
      expect(user).to eq(false)
    end

    it 'should save successfully' do
      user = User.new(email: 'email@gmail.com', password:'12345678', username: 'test').save
      expect(user).to eq(true)
    end

  end

end
