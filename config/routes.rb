Rails.application.routes.draw do
  root to: 'home#index'
  devise_for :users
  get '/search', to: 'searches#index'

end
