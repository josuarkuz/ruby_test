Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  namespace :api do
    namespace :v1 do
      post "auth/register", to: "auth#register"
      post "auth/login",    to: "auth#login"
      get  "auth/me",       to: "auth#me"

      resources :products do
        resources :comments, only: %i[index create]
      end

      resources :orders, only: %i[index show create update] do
        resources :order_items, only: %i[create update destroy]
        member do
          post :pay
          post :fulfill
          post :cancel
        end
      end
    end
  end

  mount Admin::Engine, at: "/admin" if defined?(Admin::Engine)
end
