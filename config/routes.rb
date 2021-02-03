Rails.application.routes.draw do
  namespace 'api' do
    namespace 'v1' do
      post '/registration', to: "registrations#create"
      post '/login', to: "sessions#create"
      resources :posts do
        resources :comments
        resources :tags, only: [:update]
      end
    end
  end
end
