Rails.application.routes.draw do
  

  resources :projects
  devise_for :users
  get '/search', to: 'searches#index'

  root to: 'projects#index'

end
