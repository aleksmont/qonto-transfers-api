Rails.application.routes.draw do
  post '/transactions', to: 'transaction#create'
end
