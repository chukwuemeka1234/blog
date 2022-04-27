Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  devise_for :users
  namespace :api do
    namespace :v1 do
      post 'users/sign_up' => 'users#register'
      post 'users/sign_in' => 'users#login'
      get 'users/:user_id/posts' => 'posts#index'
      post 'users/:user_id/posts' => 'posts#create'
      get 'comments' => 'comments#index'
      post 'comments/create' => 'comments#create'
    
    end
  end

  # root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index , :show ,:create ,:new, :destroy ] do
      resources :comments, only: [:create , :destroy]
      resources :likes, only: [:create]
    end
  end
end
