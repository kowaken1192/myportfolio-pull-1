Rails.application.routes.draw do
  root 'profile#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/signin', to: 'session#new', as: 'signin'
    post '/signin', to: 'session#create'
  end

  get 'profile/index'

  get 'posts/index', to: 'posts#index'
  post '/posts', to: 'posts#create'
  get '/posts/new', to: 'posts#new', as: 'new_post'
  
  get 'map/index', to: 'map#index'
  resources :personal, only: [:show, :edit, :update]
  resources :users

  get 'search_post/index', to: 'search_post#index'
  get 'search_post/show', to: 'search_post#show'
  
  resources :posts do
    member do
      get :detail
    end
    
    resources :reviews, only: [:index, :create,:show]
  end
end
