Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api, defaults: { format: :json } do
    namespace :v1 do

      post "/login", to: "users#login"
      post "/signup", to: "users#create"

      resources :users, param: :user_id do
        member do
          resources :properties, param: :property_id do
            member do
              resources :photos, param: :photo_id
            end
          end
        end
      end

    end
  end

end
