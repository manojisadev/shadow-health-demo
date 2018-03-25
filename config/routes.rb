Rails.application.routes.draw do
  resources :trivia_questions
  #play trivia
  get '/play',                       to:'trivia_questions#play'
  post '/answer',                     to:'trivia_questions#answer'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
