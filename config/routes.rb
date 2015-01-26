Rails.application.routes.draw do
  root 'home#index'

  get '/auth/:provider/callback' => 'session#create'
  get '/signout' => 'session#destroy', :as => :signout
  get '/search' => 'home#search', :as => :search
end
