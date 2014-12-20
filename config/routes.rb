Rails.application.routes.draw do
  

  resources :projects do
    resources :stories
  end
  devise_for :users
  get '/search', to: 'searches#index'

  root to: 'projects#index'

end
