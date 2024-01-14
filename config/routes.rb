Rails.application.routes.draw do
  namespace :exhibitor do
    get 'home/index'
  end
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
 
  constraints subdomain: 'admin' do
    scope module: 'admin', as: 'admin' do
      root to: 'home#index'
    end
  end

  constraints subdomain: 'exhibitor' do
    scope module: 'exhibitor', as: 'exhibitor' do
      root to: 'home#index'
    end
  end

  root to: 'home#index'
end
