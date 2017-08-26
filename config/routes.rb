# frozen_string_literal: true

Rails.application.routes.draw do
  root 'weather#form'

  resources :weather do
    collection do
      get 'random'
      get 'form'
      get 'city', to: 'weather#form'
      get 'temperature_unit'
      post 'city'
    end
  end
end
