Rails.application.routes.draw do
  default_url_options host: ENV.fetch("APPLICATION_HOST")

  devise_for :stores, controllers: {
    sessions: 'stores/sessions',
    registrations: 'stores/registrations'
  }
  scope path: '/api' do
    api_version(module: "Api::V1", path: { value: "v1" }, defaults: { format: 'json' }) do
      resources :products, only: [:index]
      resources :product_actions, only: [:create]
      resources :stores, only: [:show]
      resources :categories, only: [:index, :show]
    end
  end
  devise_scope :store do
    get '/sign_out', to: 'devise/sessions#destroy', as: :sign_out
    get 'stores/ledger', to: 'stores/sessions#ledger'
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'home', to: 'home#show'
  resource :stores do
    resources :catalog, controller: 'stores/catalog'
  end
  get 'stores/payments/about'
  get 'landing/show'
  match '/search', to: 'landing#search', via: 'post'
  root to: 'home#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
