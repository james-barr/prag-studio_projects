Rails.application.routes.draw do

  get 'signin' => "sessions#new"

  resource :session

  get "signup" => "users#new"

  resources :users
  root "projects#index"

  resources :projects do
    resources :pledges
  end
end
