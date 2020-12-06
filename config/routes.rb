Rails.application.routes.draw do
  resources :checkins
  resources :pronouns
  resources :volunteers
  resources :requests
  resources :events
  resources :churches
  resources :carriers
  resources :messages
  resources :users, only: [:index] do
    post :impersonate, on: :member
    post :stop_impersonating, on: :collection
  end
  #resources :offerings
  root to: 'pages#home'

  devise_for :users
  match '/alert',:to => 'checkins#alert', :via => :get
  match '/checkin',:to => 'checkins#checkin', :via => :get
  match '/list',:to => 'checkins#list', :via => :get
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
  match '/missing',:to => 'pages#missing', :via => :get
  match '/checkinEmail',:to => 'pages#checkinEmail', :via => :get
  match '/thankyou',:to => 'pages#thankyouEmail', :via => :get
  match '/ackgift',:to => 'offerings#ack', :via => :get
  #resources :sessions, only: [:create,:destroy]
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'
  


end
