Rails.application.routes.draw do

  get 'sessions/new'

  #root
  root 'welcome#home'
  
  #resources
  resources :users
  resources :attractions
  
  #signin
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'
  

end