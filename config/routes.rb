Rails.application.routes.draw do
  resources :trivia_questions do
    resources :answers, only: [:show] do
      post :check, on: :collection
      delete :destroy, on: :collection
    end
    get :play, on: :collection
  end
  get '/ranking',                    to:'pages#ranking'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'pages#home'
end
