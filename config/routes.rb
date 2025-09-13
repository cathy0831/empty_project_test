Rails.application.routes.draw do
  root to: "session#index"
  get "login", to: "session#new"
  post "login", to: "session#create"
  delete "logout", to: "session#destroy"
  post "reset_password", to: "session#reset_password"

  namespace :setting do
    # 使用者
    resources :users, except: [:show, :destroy]

    # 權限
    resources :permissions, except: [:show, :destroy]

    # 匯入
    get "import", to: "import#index"
    post "import", to: "import#import"
  end
end
