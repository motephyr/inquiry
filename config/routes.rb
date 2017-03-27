Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'appraisals#index'

  resources :welcome do
    collection do
      get 'demo'
    end
  end

  resources :users, only: [] do
    collection do
      get 'edit_password'
      patch 'update_password'
    end
  end

  namespace :account do
    resources :user_infos do
      collection do
        get 'edit_status'
        get 'edit_info'
        patch 'update_info'
      end
    end
    resources :user_surveys
    resources :appraisals do
      member do
        post 'update_care'
      end
    end
  end

  resources :activities
  resources :appraisals
  resources :appraisal_messages
  resources :appraisal_prices

end
