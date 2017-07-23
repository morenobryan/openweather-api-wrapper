Rails.application.routes.draw do
  root 'weather#form'

  resources :weather do
    collection do
      get 'random'
      get 'form'
      post 'city'
    end
  end
end
