Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  resources :users do
    resources :posts do
      resources :comments, only: [:create, :new]
      resources :likes, only: [:create]
    end
  end
end
