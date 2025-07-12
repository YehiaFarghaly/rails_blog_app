Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }, defaults: { format: :json }

  resources :posts, defaults: { format: :json } do
    resources :comments, only: %i[create update destroy], defaults: { format: :json }
  end

  resources :tags, only: %i[index show], defaults: { format: :json }

  root 'posts#index'
end