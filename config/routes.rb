Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create] do
        collection do
          get :confirm_email
          get :reset_password
          post :authenticate
          get :recovery_password_confirmation
          get :check_email
          post :recovery_password
          resources :profile, module: :users, only: [] do
            collection do
              get :show
              put :update
              delete :destroy
              patch :change_password
              patch :change_email
              patch :change_avatar
            end
          end
        end
        resources :company, except: %i[index]
        resources :products
        resources :assets
        resources :patterns
        resources :mediasets
      end
      resources :sessions, only: [] do
        collection do
          post :login
          post :refresh_session
          get :current
          delete :logout
        end
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
