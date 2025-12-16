Rails.application.routes.draw do
  devise_for :users

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
  end

  resource :meal_items, only: [] do
    collection do
      patch :mark_as_cooked
      patch :remove_from_plan
    end
  end
end
