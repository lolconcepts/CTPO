Rails.application.routes.draw do
  resources :volunteers
  resources :requests
  resources :events
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
  match 'test/',:to => 'pages#test', :via => :get
  match '/adminify',:to => 'pages#adminify', :via => :get
  #resources :sessions, only: [:create,:destroy]
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'


end
