Rails.application.routes.draw do
  
  get '/', to: 'application#index'

  namespace :api do
    namespace :v1 do
      resources :users
    end
  end
 end
