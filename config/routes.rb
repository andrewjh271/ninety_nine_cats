Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :cats
  resources :cat_rental_requests, only: [:create, :new, :show] do
    member do
      post 'deny'
      post 'approve'
    end
  end

  resources :users, only: [:new, :create]

  resource :sessions, only: [:new, :create, :destroy]
end
