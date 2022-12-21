Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'dashboard#index'

  resources :connections, only: %i[create destroy] do
    resources :accounts, only: [:index]

    collection do
      get 'callback/:uuid', action: 'callback', as: 'callback'
    end

    member do
      put :refresh
      post :reconnect
    end
  end

  resources :accounts, only: [] do
    resources :transactions, only: [:index]
  end
end
