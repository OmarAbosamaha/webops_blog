require 'rails_helper'

RSpec.describe "Registrations", type: :request do
  user_params = {user: {
                        username: Faker::Internet.username,
                        email: Faker::Internet.email,
                        password: Faker::Internet.password
                }}
  user_invalid_params = {user: {
                        username: 'test',
                        password: 'pass12345'
                }}

  context 'POST #create' do
    it 'should create a new user' do
      headers = { "ACCEPT" => "application/json" }
      post '/api/v1/registration', :params => user_params, :headers => headers
      expect(response.status).to eq(200)
    end

    it 'should not create a new user' do
      headers = { "ACCEPT" => "application/json" }
      post '/api/v1/registration', :params => user_invalid_params, :headers => headers
      expect(response.status).to eq(422)
    end
  end
end
