Rails.application.routes.draw do
  get "terms",   to: "pages#terms"
  get "privacy", to: "pages#privacy"
  get "how_to", to: "pages#how_to"
  devise_for :users, controllers: {
    passwords: "passwords"
  }

  root "tops#index"

  get "home", to: "home#index"

  resources :meal_plans do
    collection do
      post :confirm
    end
  end

  resources :master_menus
  resources :my_menus do
    collection do
      post :import_from_master
    end

    member do
      post :add_meal_item
    end
  end

  resources :meal_items, only: [] do
    collection do
      patch :bulk_update
    end
  end
end
