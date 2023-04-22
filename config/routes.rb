Rails.application.routes.draw do
  root to: "homes#top"
  
  devise_for :users
  
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  
  resources :sheets do
    collection do
      get 'search'
    end
  end
  
  resources :users, only:[:show, :edit, :update, :destroy]
  
end
