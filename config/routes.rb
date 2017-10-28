Rails.application.routes.draw do

  resources :status, only: :index

  resources :contributions, only: :index

  resources :debts, only: :index

  resources :expenses, only: :index

  resources :filers, only: :index

  resources :receipts, only: :index

  post "/transactions" => 'transactions#show'

end
