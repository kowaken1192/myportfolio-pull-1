Rails.application.routes.draw do
  root 'profile#index'

  devise_for :users, controllers: {
    registrations: 'users/registrations'
  }
  devise_scope :user do
    get '/signin', to: 'session#new', as: 'signin'
    post '/signin', to: 'session#create'
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  get 'unsubscribe/:id' => 'users#unsubscribe', as: 'confirm_unsubscribe'
  patch ':id/withdraw' => 'users#withdraw', as: 'withdraw_user'
  put ':id/withdraw' => 'users#withdraw'

  get 'profile/index'

  resources :map, only:  [:index]

  resources :personal, only: [:show, :edit, :update]

  resources :users, only: [:index, :show, :edit, :update,:unsubscribe,:withdraw] do    
    member do
      get :favorites
    end
  end

  get 'search_post/index'
  get 'search_post/show'
  get 'search_post/count_by_prefecture', to: 'search_post#count_by_prefecture'

  resources :posts do
    member do
      get :all_reviews
      get :related
    end
    resources :reviews, only: [:index,:new,:create]
    resource :favorites, only: [:create, :destroy]
  end
  resources :reviews, only: [:show]
end
