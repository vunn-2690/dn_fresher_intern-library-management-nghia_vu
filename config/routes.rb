Rails.application.routes.draw do
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
    get "/login", to: "sessions#new"
    post "/login", to: "sessions#create"
    get "/logout", to: "sessions#destroy"
    resources :books, only: :show
    get "/signup", to: "users#new"
    post "/signup", to: "users#create"
    resources :carts, only: %i(index create destroy) do
      get :reset, on: :collection
    end
    resources :shops, only: %i(show index) do
      resources :books do
        collection {post :import}
      end
    end
    resources :users, only: %i(new show create) do
      namespace :shop do
        resources :orders, only: %i(index show) do
          put :approve, on: :member
        end
      end
      resources :orders, only: %i(new create index) do
        get "/cancel", to: "orders#cancel"
      end
    end 
  end
end
