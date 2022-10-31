Rails.application.routes.draw do
  resources :recipes
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get 'welcome/index' => 'welcome#index' 

  # Defines the root path route ("/")
  # root "articles#index"
  root 'welcome#index'
end
