Rails.application.routes.draw do
  resources :books do
    collection do
      get :updateLib
    end
  end
  devise_for :users
  resources :libraries
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
