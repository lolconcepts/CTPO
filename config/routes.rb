Rails.application.routes.draw do
  resources :carriers
  root to: 'pages#home'
  devise_for :users
  
  #resources :sessions, only: [:create,:destroy]
  post ':controller(/:action(/:id(.:format)))'
  get ':controller(/:action(/:id(.:format)))'


end
