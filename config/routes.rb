Rails.application.routes.draw do

  root 'galleries#home'

  resources :galleries do
    resources :share, only: [:new, :create]
    resources :photos do
      resources :share, only: [:new, :create]
    end
  end
  resources :users

  get    '/login'                           => 'sessions#new',       as: :login
  post   '/login'                           => 'sessions#create'
  delete '/logout'                          => 'sessions#destroy',   as: :logout
  get    '/galleries'                       => 'galleries#index',    as: :index

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
