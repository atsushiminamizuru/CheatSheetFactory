Rails.application.routes.draw do
  root to: "homes#top"
  
  devise_for :users
  
  devise_scope :user do
    get '/users', to: 'devise/registrations#new'
  end
  
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end
  
  resources :sheets do
    resources :comments, only:[:create, :update, :destroy, :edit]
    collection do
      get 'search'
    end
    resources :favorites, only: [:create, :destroy]
    member do
      get 'download'
    end
  end
  
  resources :users, only:[:show, :edit, :update, :destroy] do
    resources :favorites, only: [:index]
    resources :relationships, only: [:create, :destroy]
    get 'followings', to: 'relationships#followings', as: 'followings'
    get 'followers', to: 'relationships#followers', as: 'followers'
  end
  
end
