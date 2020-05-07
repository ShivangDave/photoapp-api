Rails.application.routes.draw do

  get '/', to: 'application#index'

  namespace :api do
    namespace :v1 do
      resources :posts
      resources :users
      resources :profiles
    end
  end

end
