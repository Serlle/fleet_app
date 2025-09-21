Rails.application.routes.draw do
  resources :vehicles do
    resources :maintenance_services
  end

  namespace :api do
    namespace :v1 do
      post 'auth/login', to: 'auth#login'

      resources :vehicles do
        resources :maintenance_services, only: [:index, :create]
      end

      resources :maintenance_services, only: [:update]

      resources :reports do
        collection do
          get 'maintenance_summary'
        end
      end
    end
  end
end
