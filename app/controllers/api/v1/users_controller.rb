module API
  module V1
    class ArticlesController < ApplicationRecord
      def index
        users = User.order('created_at DESC');
        render json: {status: 'SUCCESS', message:'Loaded users', data:users},status: :ok
      end

  end
end
