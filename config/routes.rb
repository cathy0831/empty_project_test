Rails.application.routes.draw do
  root to: "session#index"
  get "login", to: "session#new"
  post "login", to: "session#create"
  delete "logout", to: "session#destroy"
  post "reset_password", to: "session#reset_password"

  namespace :setting do
    resources :users
    resources :permissions
  end
end
