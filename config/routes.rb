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
end
