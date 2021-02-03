module API
  module V1
    class SessionsController < ApplicationRecord
      skip_before_action :authenticate

      def create
        user = User.find_by(email: auth_params[:email])
        if user.authenticate(auth_params[:password])
          jwt = Auth.issue({user: user.id})
          render json: {status: 'SUCCESS', message:'Logged in',jwt: jwt},status: :ok
        end
      end

  private
    def auth_params
      params.require(:auth).permit(:email, :password)
    end


    end
  end
end
