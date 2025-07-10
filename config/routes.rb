Rails.application.routes.draw do
  devise_for :users, controllers: {
    sessions: 'users/sessions'
  }, defaults: { format: :json }

  resources :posts, defaults: { format: :json } do
    resources :comments, only: [:create, :update, :destroy], defaults: { format: :json }
  end

  resources :tags, only: [:index, :show], defaults: { format: :json }
  root "posts#index"
end