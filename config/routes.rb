Rails.application.routes.draw do
  namespace :v1 do
    resources :pilots, only: [:index, :show, :create] do
      member do
        get 'travels', to: 'travels#index'
        post 'grant_credits', to: 'pilots#grant_credits'
        post 'travel_between_planets', to: 'travels#travel_between_planets'
        post 'register_fuel_refill', to: 'travels#register_fuel_refill'
      end

      resources :ships, only: [:index, :create]
    end

    resources :contracts, only: [:index, :show, :create] do
      patch :update, on: :member
      post :accept_contract, on: :member
      get :list_open_contracts, on: :collection
    end

    get 'reports/resource_weights', to: 'reports#resource_weights'
    get 'reports/resource_percentage', to: 'reports#resource_percentage'
    get 'reports/ledger_transactions', to: 'reports#ledger_transactions'
  end
end
