Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
    resources :books, only: :show
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :carts, only: %i(index create destroy) do
      get :reset, on: :collection
    end
    resources :shops, only: %i(show index) do
      resources :orders
    end
    resources :users, only: %i(new show create) do
      resources :orders, only: %i(new create index)
    end 
  end
end
