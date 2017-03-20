Rails.application.routes.draw do

  root 'galleries#home'

  resources :galleries do
    resources :photos
  end
  resources :users

  get    '/login'                           => 'sessions#new',       as: :login
  post   '/login'                           => 'sessions#create'
  delete '/logout'                          => 'sessions#destroy',   as: :logout
  get    '/share/:id'                       => 'galleries#share',    as: :share_gallery
  post   '/share/:id'                       => 'galleries#share_email'
  get    'galleries/:gallery_id/share/:id'  => 'photos#share',       as: :share_photo
  post   'galleries/:gallery_id/share/:id'  => 'photos#share_email'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
