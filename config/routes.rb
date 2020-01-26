Rails.application.routes.draw do
  resources :churches
  resources :carriers
  resources :messages
  root to: 'pages#home'
  devise_for :users
  match 'nametag/', :to => 'pages#nametag', :via => :get
  match 'nametags/', :to => 'pages#nametags', :via => :get
  match 'all_users/', :to => 'pages#all_users', :via => :get
  match 'offering/', :to => 'pages#offering', :via => :get
  match 'charge/', :to => 'pages#charge', :via => :post
  #resources :sessions, only: [:create,:destroy]
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'


end
