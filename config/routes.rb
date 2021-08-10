Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create]
      get '/forecast', to: 'forecast#index'
      post '/sessions', to: 'sessions#create'
      get '/backgrounds', to: 'search/backgrounds#index'
      post '/road_trip', to: 'road_trip#index'
    end
  end
end
