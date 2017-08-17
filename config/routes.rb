Rails.application.routes.draw do

  get "signup" => "users#new"

  resources :users
  root "projects#index"

  resources :projects do
    resources :pledges
  end
end
