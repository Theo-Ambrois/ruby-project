Rails.application.routes.draw do
  root 'movies#index'
  devise_for :users
  get 'users/index' => 'users#index', as: 'users_path'
  get 'users/list' => 'users#list', as: 'list_movie_user'
  get 'movies/:id/borrow' => 'movies#borrow', as: 'borrow_movie'
  get 'users/:id/return' => 'users#return', as: 'return_movie'
  get 'users/profile' => 'users#show', as: 'show_user'
  resources :categories
  resources :movies
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :posts
  resources :users
end
