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
  root to: 'projects#index'

end
