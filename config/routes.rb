Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  get '/autocomplete', to: 'recipes#autocomplete'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :circle_recipes, only: [:create, :destroy]
  resources :circles, except: [:edit, :destroy] do
    resources :recipes, only: [:new, :create, :show]
    get '/visio', to: 'pages#visio'
  end
  resources :recipes do
    resources :comments, only: [:create, :destroy, :index ]
  end
  resources :suggestions, only: [:index, :show, :new, :create]
end
