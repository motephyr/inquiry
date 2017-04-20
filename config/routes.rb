Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: 'users/registrations' , :omniauth_callbacks => "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#index'

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

  resources :work_messages
  resources :works do
    resources :donates
    collection do
      get 'newest'
      get 'favorite'

      post 'getUrl'
    end
    member do
      post 'update_care'
      get 'update_featured'
      post 'update_published'
      get 'carers'
    end
  end

  get '/user_infos/:id', to: 'account/user_infos#show', as: :user_info
  get '/user_infos/:user_info_id/works/:id', to: 'account/works#show', as: :user_info_work

  namespace :account do
    get 'donates/donor'
    get 'donates/bedonor'

    resources :user_infos do
      resources :works
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
