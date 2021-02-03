Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post '/registration', to: "registration#create"
      post '/login', to: "sessions#create"
      resources :posts do
        resources :comments
        # resources :tags
      end
    end
  end
end
