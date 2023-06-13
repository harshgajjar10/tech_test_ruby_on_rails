Rails.application.routes.draw do
  resources :users, only: [:edit, :update]
  resources :doctor_infos
  resources :appointments do 
    member do
      put :update_status
    end
    collection do
      get :get_time_slots
    end
  end
  devise_for :users, :controllers => { registrations: 'registrations' }
  root "appointments#index"
end
