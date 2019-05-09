Rails.application.routes.draw do
  apipie
  namespace :v0 do
    resources :users, only: [:create]

    resources :tokens, only: [:create]

    resources :products, only: [:index]

    namespace :my do
      resources :products

      resources :placing_orders, only: [:index, :show, :create]

      resources :received_orders, only: [:index, :show]
    end
  end
end
