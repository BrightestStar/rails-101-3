Rails.application.routes.draw do
  devise_for :users

  resources :groups do
    
  end

  root 'groups#index'
end
