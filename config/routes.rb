Rails.application.routes.draw do
  root to: "homes#top"
  devise_for :users
  resources :sheets
  resources :users, only:[:show, :edit, :update, :destroy]
  
end
