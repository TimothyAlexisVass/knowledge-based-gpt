Rails.application.routes.draw do
  resources :questions, only: [:index]

  post '/gpt', to: 'gpt#gpt'

  root "questions#index"
end
