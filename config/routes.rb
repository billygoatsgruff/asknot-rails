Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  namespace :api do
    namespace :v1 do
      resources :tweets, only: [:index]
      resources :sessions, only: [:create]
    end
  end
end
