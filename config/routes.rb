Rails.application.routes.draw do
  root 'homes#index'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  devise_scope :user do
    get '/signin', to: 'devise/sessions#new', as: 'new_user_signin'
    post '/signin', to: 'devise/sessions#create', as: 'user_signin'
    post '/users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  resources :users, only: [:index, :show, :edit, :update] do
    member do
      get :favorites
      get 'unsubscribe', to: 'users#unsubscribe', as: 'confirm_unsubscribe'
      patch 'withdraw', to: 'users#withdraw', as: 'withdraw'
    end
  end

  resources :posts do
    member do
      get :all_reviews
      get :related
    end
    resource :favorites, only: [:create, :destroy]
    resources :reviews, only: [:new, :create]
  end

  resources :search_post, only: [:index] 
  get 'search_post/result', to: 'search_post#result'
  get 'search_post/count_by_prefecture', to: 'search_post#count_by_prefecture'
   
  post '/save_language', to: 'application#save_language'
  resources :chatbots, only: [:new, :create]
  post '/chatbots/result', to: 'chatbots#result'
  resources :homes, only: [:index]
  resources :service, only: [:index]
  resources :personal, only: [:show, :edit, :update]
  resources :map, only: [:index]
end
