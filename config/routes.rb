# frozen_string_literal: true

Rails.application.routes.draw do
  root 'weather#form'

  resources :weather do
    collection do
      get 'random'
      get 'form'
      get 'city', to: 'weather#form'
      get 'unit'
      post 'city'
    end
  end
end
