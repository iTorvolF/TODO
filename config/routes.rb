# frozen_string_literal: true

Rails.application.routes.draw do
  mount RootApi => '/'
  get :toggle, to: 'locales#toggle'
  namespace :admin do
    root 'users#index'
    resources :roles
    resources :users do
      member do
        get :toggle, action: :toggle
      end
    end
  end

  devise_for :users do
    get '/users/sign_out' => 'devise/sessions#destroy', :as => :destroy_user_session
  end
  resources :users

  resources :events do
    resources :items
  end

  # devise_for :admin_users, ActiveAdmin::Devise.config
  # ActiveAdmin.routes(self)
  get :about, to: 'about#index'
  get :help, to: 'help#index'
  root 'events#index'
end
