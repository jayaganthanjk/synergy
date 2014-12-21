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

  resources :bugs, only: [:new ,:create, :destroy]

  resources :comments

  resources :uploads

  devise_for :users, :controllers => {:registrations => "registrations",
                                      :invitations => "invitations" }
                                      
  get '/search', to: 'searches#index'
  get '/findUsers', to: 'home#findUsers'
  post '/changestorystate', to: 'stories#next_state'
  root to: 'projects#index'

end
