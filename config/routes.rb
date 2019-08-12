Rails.application.routes.draw do
  devise_for :stores
  scope path: '/api' do
    api_version(module: "Api::V1", path: { value: "v1" }, defaults: { format: 'json' }) do
    end
  end
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  get 'pages/home'
  get 'pages/landing'
  match '/start', to: 'pages#start', via: 'post'
  # resources :pages do
  #   member do
  #     post :start
  #   end
  # end
  root to: 'pages#user_helper'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
