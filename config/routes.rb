Rails.application.routes.draw do

  resources :types
  get 'signin' => "sessions#new"

  resource :session

  get "signup" => "users#new"

  resources :users
  root "projects#index"

  resources :projects do
    resources :pledges
    resources :follows
  end
end
