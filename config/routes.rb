Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :circle_recipes, only: [:create, :destroy]
  resources :circles, except: [:edit, :destroy] do
    resources :recipes, only: [:new, :create, :show]
  end
  resources :recipes
  resources :suggestions, only: [:index, :show, :new, :create]
end
