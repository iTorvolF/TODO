# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    root 'users#index'
    resources :users
  end
  devise_for :users
  mount RootApi => '/'
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
