Rails.application.routes.draw do
  

  get 'activities', to: 'activities#index'

  resources :projects do
    member do
      get 'resource'
      post 'addUser'
    end
    resources :stories do
      resources :tasks
    end
  end


  devise_for :users
  get '/search', to: 'searches#index'
  get '/findUsers', to: 'home#findUsers'
  root to: 'projects#index'

end
