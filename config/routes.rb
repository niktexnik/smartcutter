Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'
  get 'up' => 'rails/health#show', as: :rails_health_check

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :users, only: [:create] do
        collection do
          post :confirmation
        end
        resources :company, except: %i[index]
        resources :products
        resources :assets
        resources :patterns
        resources :mediasets
      end
      resources :companies do
        resources :products
        resources :assets
        resources :patterns
        resources :mediasets
      end
      resources :mediasets do
        resources :entities
        resources :photos
      end
    end
  end
end
