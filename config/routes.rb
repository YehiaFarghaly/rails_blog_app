Rails.application.routes.draw do
  devise_for :users
  resources :posts do

    resources :comments, only: [:create, :update, :destroy]

  end

  resources :tags, only: [:index, :show]

  root "posts#index"
end