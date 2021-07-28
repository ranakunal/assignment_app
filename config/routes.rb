Rails.application.routes.draw do
  
  resource :products, only: [:index, :create]
  resources :import, only: [:index, :new, :create, :destroy]
  root 'products#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
