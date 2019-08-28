Rails.application.routes.draw do
  devise_for :stores, controllers: {
    sessions: 'stores/sessions',
    registrations: 'stores/registrations'
  }
  scope path: '/api' do
    api_version(module: "Api::V1", path: { value: "v1" }, defaults: { format: 'json' }) do
      resources :products, only: [:index]
    end
  end
  devise_scope :store do
    get '/sign_out', to: 'devise/sessions#destroy', as: :sign_out
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'stores/catalog/show'
  get 'stores/catalog/new'
  get 'home/show'
  get 'landing/show'
  match '/search', to: 'landing#search', via: 'post'
  root to: 'landing#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
