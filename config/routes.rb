Rails.application.routes.draw do
  devise_for :users
  resources :boardgames do
    resources :reviews
  end

  resources :users, only: [:index, :destroy]

  namespace :api do
    namespace :v1 do
      resources :reviews, only: [:index, :show, :create]
    end
  end
  root to: "homes#index"

end
