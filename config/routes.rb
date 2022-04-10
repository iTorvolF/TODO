# frozen_string_literal: true

Rails.application.routes.draw do
  get 'about', to: 'about#index', as: 'about_index'
  get 'help', to: 'help#index', as: 'help_index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root 'events#index'
end
