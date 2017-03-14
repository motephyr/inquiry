Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root 'welcome#index'

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

  resources :appraisals
end
