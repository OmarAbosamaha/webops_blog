module Api
  module V1
    class SessionsController < ApplicationController
      skip_before_action :authenticate

      def create
        user = User.find_by(email: auth_params[:email])
        if !user
          render json: {status: 'ERROR', message:'User not created', data:nil},status: :unprocessable_entity
        else
          if user.authenticate(auth_params[:password])
            jwt = Auth.issue({user: user.id})
            render json: {status: 'SUCCESS', message:'Logged in',jwt: jwt},status: :ok
          end
        end
      end

  private
    def auth_params
      params.require(:auth).permit(:email, :password)
    end


    end
  end
end
