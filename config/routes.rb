Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resource :current_user, only: [:show, :update]
      resources :tweets, only: [:index]
      resources :suggested_tweets, only: [:create]
      resources :sessions, only: [:create]
      resources :retweets, only: [:create, :destroy]
      resources :devices, only: [:create]
      resources :trends, only: [:index]
      resources :url_actions, only: [:index]
      resource :version, only: :show
    end
  end
end
