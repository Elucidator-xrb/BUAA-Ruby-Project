Rails.application.routes.draw do
  devise_for :manipulators, controllers: {
    sessions: 'manipulators/sessions',
    registrations: 'manipulators/registrations'
  }
  resources :shoppinglists do
    resources :items
    collection do
      post 'conduct'
    end
  end
  resources :products

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'home/index' => 'home#index'
  post 'home/index' => 'home#authorize'

  # Defines the root path route ("/")
  root "home#index"
end
