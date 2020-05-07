Rails.application.routes.draw do
  
  namespace :api do
    namespace :v1 do
      resources :profiles
    end
  end
  get '/', to: 'application#index'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
 end
