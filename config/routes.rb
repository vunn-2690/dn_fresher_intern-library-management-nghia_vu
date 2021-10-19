Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get ":locale/login" => "devise/sessions#new", :as => :new_user_session
    post ":locale/login" => "devise/sessions#create", :as => :user_session
    get ":locale/logout" => "devise/sessions#destroy", :as => :destroy_user_session
  end
  
  scope "(:locale)", locale: /en|vi/ do
    root "static_pages#home"
    get "static_pages/home"
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
