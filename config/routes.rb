Rails.application.routes.draw do

  resources :status, only: :index

  resources :contributions, only: :index

end
