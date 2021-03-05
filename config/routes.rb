Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'transactions#home'
  get '/signup', to: 'users#new'
  resources :users
  # resources :transactions, only: [:update, :edit]
  get    '/transactions',   to: 'transactions#new'
  # get    '/transactions',   to: 'transactions#edit'
  post   '/transactions',   to: 'transactions#create'
  get   '/transactions/:id',   to: 'transactions#update'

  get    '/login',   to: 'sessions#new'
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
end
