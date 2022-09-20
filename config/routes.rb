Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get '/mechanics', to: 'mechanics#index'
  # get '/mechanics/:id', to: 'mechanics#show'
  # post '/mechanics/:mechanic_id/ride_mechanics', to: 'ride_mechanics#show'

  resources :mechanics, only: [:show, :index] do
    resources :ride_mechanics, only: :create
  end

  
end
