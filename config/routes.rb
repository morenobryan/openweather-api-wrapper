Rails.application.routes.draw do
  resources :weather do
    collection do
      get 'random'
      get 'city'
    end
  end
end
