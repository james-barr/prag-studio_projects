Rails.application.routes.draw do

  resources :types
  get 'signin' => "sessions#new"

  resource :session

  get "signup" => "users#new"

  resources :users
  root "projects#index"

  get "projects/filter/:scope" => "projects#index", as: :filter_projects

  resources :projects do
    resources :pledges
    resources :follows
  end
end
