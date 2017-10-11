Rails.application.routes.draw do

  resources :status, only: :index

  resources :contributions, only: :index

  resources :debts, only: :index

end
