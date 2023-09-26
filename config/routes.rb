Rails.application.routes.draw do
  root 'profile#index'

  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
    get '/signin', to: 'session#new', as: 'signin'
    post '/signin', to: 'session#create'
  end

  get 'profile/index'

  resources :map, only:  [:index]

  resources :personal, only: [:show, :edit, :update]

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :favorites
    end
  end

  get 'search_post/index'
  get 'search_post/show'
  
  resources :posts do
    member do
      get :detail
      get :all_reviews
    end
    
    resources :reviews, only: [:index,:new,:create,:show]
  end
  resources :posts do
    resource :favorites, only: [:create, :destroy]
  end
end
