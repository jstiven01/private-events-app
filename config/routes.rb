Rails.application.routes.draw do

  root   'static_pages#home'
  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  resources :users, only: [:new, :create, :show]
  resources :events, only: [:new, :create, :show, :index]
  resources :user_events, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
