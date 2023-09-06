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

  resources :posts do
    resources :reviews, only: [:index, :create]
  end
end
