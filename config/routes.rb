Rails.application.routes.draw do
  devise_for :users
  resources :boardgames do
    resources :reviews
  end

  resources :users, only: [:index, :destroy]

  namespace :api do
    namespace :v1 do
      resources :votes do
        collection do
          post 'create_or_destroy'
        end
      end
    end
  end
  root to: "homes#index"

end
