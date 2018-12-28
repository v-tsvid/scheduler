Rails.application.routes.draw do
  get '/schedule', to: 'home#schedule'
  post '/schedule', to: 'home#schedule'

  root to: 'home#schedule'
end
