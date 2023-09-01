Rails.application.routes.draw do
  get 'profile/index'
  root 'profile#index'
  get 'homes/index'
  devise_for :users
  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end
  resources :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
