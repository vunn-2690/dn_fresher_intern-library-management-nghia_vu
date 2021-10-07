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
    resources :shops, only: %i(show index)
    resources :users, only: %i(new show create) do
      resources :shops, only: %i(new create)
      namespace :shop do
        resources :orders, only: %i(index show) do
          member do 
            put :approve
            put :disclaim
          end
        end
        resource :shops, only: :show
        resources :books do
          collection {post :import}
        end
      end
      resources :orders, only: %i(new create index show) do
        put :cancel, on: :member
      end
    end 
  end
end
