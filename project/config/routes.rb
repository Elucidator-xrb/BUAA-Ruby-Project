Rails.application.routes.draw do
  resources :shoppinglists do
    resources :items
    collection do
      post 'conduct'
    end
  end
  resources :products

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'home/index' => 'home#index'

  # Defines the root path route ("/")
  root "home#index"
end
