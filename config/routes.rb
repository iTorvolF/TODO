# frozen_string_literal: true
require 'resque/server'

Rails.application.routes.draw do
  devise_for :users#, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  mount RootApi => '/'
  mount Resque::Server.new, at: '/resque'

  resources :events do
    resources :items
  end
  
  get :toggle, to: 'locales#toggle'
  get :about, to: 'about#index'
  get :help, to: 'help#index'
  root 'events#index'
end
