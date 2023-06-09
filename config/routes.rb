Rails.application.routes.draw do
  devise_for :users
  
  root to: 'homes#top'
  get 'home/about', to: 'homes#about'
  
  resources :users, only: [:index, :show, :edit, :update]
  
  resources :reviews, only:[:index, :show, :edit, :new, :create, :update, :destroy] do
    resource :favorites, only:[:create, :destroy]
    resources :post_comments, only:[:create, :destroy]

  end
end
