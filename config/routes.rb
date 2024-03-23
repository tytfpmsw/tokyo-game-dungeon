Rails.application.routes.draw do
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
 
  constraints subdomain: 'admin' do
    devise_for :administrators, controllers: {
      sessions: 'administrators/sessions',
      registrations: 'administrators/registrations'
    }
    scope module: 'admin', as: 'admin' do
      root to: 'home#index'
      resources :events do
        resources :place_blocks
        resources :exhibitors, only: [:index, :new, :create]
        resources :exhibit_submissions do
          # memberでidを含むURLを生成する 例: /:event_id/exhibit_submissions/:exhibit_submission_id/approve
          member do
            post :approve
            post :reject
          end
        end
        resources :exhibitors, only: [:index, :new, :create]
      end
    end
  end

  constraints subdomain: 'exhibitor' do
    devise_for :exhibitors, controllers: {
      sessions: 'exhibitors/sessions',
      registrations: 'exhibitors/registrations'
    }
    scope module: 'exhibitor', as: 'exhibitor' do
      root to: 'home#index'
      resources :events, only: [:index, :show] do
        resources :exhibit_submissions
      end
    end
  end

  constraints subdomain: lambda { |sd| !%w[admin biz].include?(sd) } do
    scope module: 'front', as: 'front' do
      root to: 'portal#index'
      resources :events, only: [:index, :show] do
        resources :exhibit_informations, only: [:index, :show]  
      end
    end
  end
end
