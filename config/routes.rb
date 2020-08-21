Rails.application.routes.draw do
  resources :checkins
  resources :pronouns
  resources :volunteers
  resources :requests
  resources :events
  resources :churches
  resources :carriers
  resources :messages
  #resources :offerings
  root to: 'pages#home'
  devise_for :users
  match '/alert',:to => 'checkins#alert', :via => :get
  match '/checkin',:to => 'checkins#checkin', :via => :get
  match 'nametag/', :to => 'pages#nametag', :via => :get
  match 'nametags/', :to => 'pages#nametags', :via => :get
  match 'all_users/', :to => 'pages#all_users', :via => :get
  match 'offering/', :to => 'pages#offering', :via => :get
  match 'charge/', :to => 'pages#charge', :via => :post
  match 'test/',:to => 'pages#test', :via => :get
  match '/adminify',:to => 'pages#adminify', :via => :get
  match '/financify',:to => 'pages#financify', :via => :get
  match '/card', :to => 'pages#offeringcard', :via => :get
  match '/sucard', :to => 'pages#sucard', :via => :get
  match 'users/:id' => 'users#destroy', :via => :delete, :as => :admin_destroy_user
  match '/offerings',:to => 'offerings#index', :via => :get
  #resources :sessions, only: [:create,:destroy]
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'


end
