Rails.application.routes.draw do
  devise_for :users
  resources :boardgames do
    resources :reviews, only: [:index, :new, :create]
  end

  resources :reviews, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "homes#index"
end
