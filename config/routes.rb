Rails.application.routes.draw do
  devise_for :users, :groups
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  #get 'site/index'
  
  
  controller :site do
    get 'site/index'    => :index
    get 'site/finder'   => :finder
  end
  
  controller :groups do
    get 'groups/index'  => :index
    get 'groups/new'    => :new
    get 'groups/show'   => :show
    get 'groups/showAll'  =>:showAll
  end
  
  resources :groups do
    post :addUserToGroup, :on       => :collection
    post :removeUserFromGroup, :on  => :collection
  end
  
  root to: 'site#index'
end
