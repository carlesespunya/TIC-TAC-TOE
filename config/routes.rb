Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  resources :games
  resources :bookings, only: [:create]
  resources :games, only: [] do
    member do
      patch :change_turn
    end
  end
end
