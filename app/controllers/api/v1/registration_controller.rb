module API
  module V1
    class SessionsController < ApplicationRecord
      skip_before_action :authenticate

      def create
        user = user.new(user_params)
        if user.save
          render json: {status: 'SUCCESS', message:'User created', data:user},status: :ok
        else
          render json: {status: 'ERROR', message:'User not created', data:user.errors},status: :unprocessable_entity
        end
      end

  private
    def user_params
      params.require(:user).permit(:username, :email, :password)
    end


    end

end
