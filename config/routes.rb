Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :chatrooms do
    resources :chatroom_users
  end

  get 'site/index'
  root to: 'site#index'
end
