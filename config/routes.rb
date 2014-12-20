Rails.application.routes.draw do
  

  get 'activities', to: 'activities#index'

  resources :projects do
    resources :stories do
      resources :tasks
    end
  end
  devise_for :users
  get '/search', to: 'searches#index'

  root to: 'projects#index'

end
