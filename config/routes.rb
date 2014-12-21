Rails.application.routes.draw do
  

  get 'activities', to: 'activities#index'

  resources :projects do
    resources :stories do
      resources :tasks
    end
  end

  resources :bugs, only: [:new ,:create, :destroy]

  resources :comments


  devise_for :users, :controllers => {:registrations => "registrations",
                                      :invitations => "invitations" }
  get '/search', to: 'searches#index'

  root to: 'projects#index'

end
