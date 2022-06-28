# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  resources :users
  namespace :admin do
    resources :users
    root 'users#index'
  end
  mount RootApi => '/'
  mount Resque::Server.new, at: '/resque'
  # mount Sidekiq::Web => '/sidekiq'
  get :toggle, to: 'locales#toggle'

  resources :events do
    resources :items
  end

  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  get :about, to: 'about#index'
  get :help, to: 'help#index'
  root 'events#index'
end
