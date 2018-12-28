Rails.application.routes.draw do
  get '/index', to: 'home#index'
  post '/schedule', to: 'home#schedule'

  root to: 'home#index'
end
