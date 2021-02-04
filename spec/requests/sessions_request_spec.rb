require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  user_params = {auth: {
                        email: 'email@gmail.com',
                        password: '12345678'
                }}
  user_invalid_params = {auth: {
                        email: 'testtttt@gmail.com',
                        password: 'pass12345'
                }}

  context 'POST #create' do
    it 'should login already created user' do
      user = User.new(email: 'email@gmail.com', password:'12345678', username: 'test').save
      headers = { "ACCEPT" => "application/json" }
      post '/api/v1/login', :params => user_params, :headers => headers
      expect(response.status).to eq(200)
    end

    it 'should not login a new user' do
      headers = { "ACCEPT" => "application/json" }
      post '/api/v1/login', :params => user_invalid_params, :headers => headers
      expect(response.status).to eq(422)
    end
  end
end
