Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get "users/:id/dashboard", to: "pages#dashboard", as: :dashboard

  resources :services do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
    resources :contracts, only: [:index, :show, :new, :create, :edit, :update] do
      member do
        patch :update
      end
    end
  end
  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
  get "users/new", to: "users#new", as: :new_user
  post "users", to: "users#create"
  get "users/:id", to: "users#show", as: :user
  get "users/:id/edit", to: "users#edit", as: :edit_user
  patch "users/:id", to: "users#update"

 patch "contracts/:id/update_status", to: "contracts#update_status", as: :update_status

  resources :conversations do
    resources :messages
  end
end
