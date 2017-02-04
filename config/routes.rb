Rails.application.routes.draw do

  #root
  root 'welcome#home'
  
  #resources
  resources :users
  
  #signin
  get '/signin' => 'users#signin'

end