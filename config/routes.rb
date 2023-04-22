Rails.application.routes.draw do
  root to: "homes#top"
  
  devise_for :users
  
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  
  resources :sheets do
    resources :comments, only:[:create, :update, :destroy, :edit]
    collection do
      get 'search'
    end
  end
  
  resources :users, only:[:show, :edit, :update, :destroy]
  
end
