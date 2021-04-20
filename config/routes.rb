Rails.application.routes.draw do
  default_url_options host: ENV.fetch("APPLICATION_HOST")

  scope path: '/api' do
    api_version(module: "Api::V1", path: { value: "v1" }, defaults: { format: 'json' }) do
      resources :products, only: [:index]
      resources :product_actions, only: [:create]
      resources :stores, only: [:show]
      resources :categories, only: [:index, :show]
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'home', to: 'home#show'
  get 'landing/show'
  match '/search', to: 'landing#search', via: 'post'
  root to: 'home#show'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
