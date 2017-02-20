Rails.application.routes.draw do
  root to: 'answers#new'

  resources :answers, only: [:new, :create]
  resources :surveys, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
