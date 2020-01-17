Rails.application.routes.draw do
  resources :churches
  resources :carriers
  resources :messages
  root to: 'pages#home'
  devise_for :users
  match 'nametag/', :to => 'pages#nametag', :via => :get
  #resources :sessions, only: [:create,:destroy]
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'


end
