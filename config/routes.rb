Rails.application.routes.draw do
  devise_for :stores, controllers: {
    sessions: 'stores/sessions',
    registrations: 'stores/registrations'
  }
  scope path: '/api' do
    api_version(module: "Api::V1", path: { value: "v1" }, defaults: { format: 'json' }) do
      resources :products, only: [:index]
      resources :product_actions, only: [:create]
      get 'receivers/get', to: 'receivers#show'
      delete 'receivers/delete_session', to: 'receivers#delete_session'
      resources :catalogs, only: [:update]
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
  get 'landing/show'
  match '/search', to: 'landing#search', via: 'post'
  root to: 'home#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
