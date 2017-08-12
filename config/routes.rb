Rails.application.routes.draw do
  get 'main/index'
  root 'main#index'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

   # get "/sign_in" => "sessions#new", as: "sign_in"
  # delete "/sign_out" => "sessions#destroy", as: "sign_out"
  #  get "/sign_up" => "users#new", as: "sign_up"
  #  # post "/users" => "users#create", as: "users2"
  # post "/users" => "users#create", as: "create"




end
