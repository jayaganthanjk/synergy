Rails.application.routes.draw do
  

  get 'activities', to: 'activities#index'

  resources :projects do
    member do
      get 'resource'
      post 'addUser'
      get 'completedstories'
    end
    resources :stories do
      member do
        get 'accept'
      end
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
  post '/changetaskstate', to: 'tasks#change_state'
  root to: 'projects#index'
  get '/notifications', to: 'notifications#index'
  get '/clear_all', to: 'notifications#seen_all'

end
