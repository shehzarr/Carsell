Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users

  resources :ads do
    member do
      get :close
    end
  end

  resources :charges, only: [:new, :create]

  resources :ad_steps

  resources :favorites, only: [:create, :destroy]

  get '/user/ads', to: 'user#ads'
  get '/user/favorites', to: 'user#favorites'
  get 'home/index'
  get 'home/about'
end
