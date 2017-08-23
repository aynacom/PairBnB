Rails.application.routes.draw do
  get 'payment/new'

  get 'main/index'
  get 'main/all'
  get 'main/country'
  get 'main/state'
  root 'main#index'
  get "main/reservations"
  get 'payment/new'
  post 'payment/checkout'

   get "/auth/:provider/callback" => "sessions#create_from_omniauth"
   # get 'users/show'

  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create, :show, :edit, :index, :update] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
      resources :listings do
        resources :reservations
      end

  end

   # get "/sign_in" => "sessions#new", as: "sign_in"
  # delete "/sign_out" => "sessions#destroy", as: "sign_out"
  #  get "/sign_up" => "users#new", as: "sign_up"
  #  # post "/users" => "users#create", as: "users2"
  # post "/users" => "users#create", as: "create"




end
