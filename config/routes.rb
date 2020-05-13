Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # RESOURCE ON NESTED ROUTES: https://stackoverflow.com/questions/25134198/ruby-on-rails-access-model-data-within-another-model
  
  get '/drivers', to: 'drivers#index'

  get '/drivers/:id', to: 'drivers#show'

  post '/drivers', to: 'drivers#new'

  patch '/drivers/number', to: 'drivers#edit'
  
  root to: 'homepage#index'
  # resources :trips
    
  resources :trips, except: [:index]

  resources :passengers do
    resources :trips, only: [:new, :show, :index]
  end
  
  resources :drivers

end
