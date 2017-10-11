Rails.application.routes.draw do

  resources :status, only: :index

end
