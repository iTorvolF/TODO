# frozen_string_literal: true

Rails.application.routes.draw do
  namespace :admin do
    resources :roles
    resources :users
    root 'users#index'
  end

  devise_for :users
  resources :users

  resources :events do
    resources :items
  end

  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)

  root 'events#index'
end
