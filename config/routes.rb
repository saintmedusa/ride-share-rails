Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  # RESOURCE ON NESTED ROUTES: https://stackoverflow.com/questions/25134198/ruby-on-rails-access-model-data-within-another-model
  
  # root to: 'passengers#index'
  resources :passengers do
    resources :trips
  end
  
  resources :drivers do
    resources :trips
  end
end
