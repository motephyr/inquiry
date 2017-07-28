Rails.application.routes.draw do

  mount Ckeditor::Engine => '/ckeditor'
  devise_for :users, controllers: { registrations: 'users/registrations' , :omniauth_callbacks => "users/omniauth_callbacks"}
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'works#index'

  resources :users, only: [:show] do
    collection do
      get 'edit_password'
      patch 'update_password'
    end
  end

  resources :work_messages
  resources :works do
    resources :donates
    collection do
      get 'category_page'
      post 'getUrl'
    end
    member do
      post 'update_care'
      get 'update_featured'
      post 'update_published'
      post 'report'
      get 'carers'
      get 'tags'
    end
  end

  get 'tags/:tag', to: 'account/user_infos#tag', as: :tag


  get '/user_infos/:id', to: 'account/user_infos#show', as: :user_info
  get '/user_infos/:user_info_id/works/:id', to: 'account/works#show', as: :user_info_work
  get '/user_infos/:id/personal_page', to: 'account/user_infos#personal_page', as: :personal_page
  get '/user_infos/:id/unique', to: 'account/user_infos#unique', as: :unique_page

  namespace :account do
    get 'donates/donor'
    get 'donates/bedonor'

    resources :user_infos do
      resources :works
      collection do
        get 'edit_communication'
        get 'edit_status'
        get 'edit_info'
        get 'search'
        patch 'update_communication'
        patch 'update_info'
      end
      member do
        get 'unique'
        get 'personal_page'
        get 'sip'
      end
    end
    resources :user_surveys

    get 'works', to: 'works#index'
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

  resources :welcome do
    collection do
      get 'demo'
    end
  end

  get '/policy/privacy'
  get '/policy/terms'

  # get 'twilio', to: 'twilio#index'
  # get 'twilio/token', to: 'twilio#token'
  # post 'twilio/voice', to: 'twilio#voice'
end
