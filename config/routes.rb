Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      namespace :merchants do
        resource :find_all, only: [:show], controller: :find_all
      end

      resources :merchants, only: [:index, :show] do
        resources :items, only: [:index], controller: :merchant_items
      end

      namespace :items do
        resource :find, only: [:show], controller: :find
      end

      resources :items do
        resource :merchant, only: [:show], controller: :item_merchants
      end
    end
  end
end
