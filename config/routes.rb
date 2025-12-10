Rails.application.routes.draw do
  get "meal_plans/index"
  get "meal_plans/new"
  get "meal_plans/create"
  get "meal_plans/show"
  get "master_menus/index"
  devise_for :users
  get "tops/index"
  root "tops#index"
  get "home/index"

  get "up" => "rails/health#show", as: :rails_health_check
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest

  resources :my_menus do
    collection do
      post :import_from_master   # 選択したものをマイメニューに登録
    end
  end

  resources :master_menus
  resources :meal_plans
end
