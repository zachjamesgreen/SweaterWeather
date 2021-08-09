Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users
      get '/forecast', to: 'forecast#index'
      post '/sessions', to: 'sessions#create'
      get '/backgrounds', to: 'search/backgrounds#index'
      get '/breweries', to: 'breweries#index'
    end
  end
end
