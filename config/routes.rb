Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index , :show ,:create ,:new, :destroy ] do
      resources :comments, only: [:create , :destroy]
      resources :likes, only: [:create]
    end
  end

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: %i[index show ] do
        resources :posts, only: %i[index] do
          resources :comments, only: %i[index create]
        end
      end
    end
  end
end
