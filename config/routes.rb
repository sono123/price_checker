Rails.application.routes.draw do


  ## Non-named Routes
  # root 'static_pages#home'
  # get 'static_pages/help'
  # get 'static_pages/about'
  # get 'static_pages/contact'
  # get 'users/new'


  ## Named Routes
  root               'static_pages#home'
  get 'help'      => 'static_pages#help'
  get 'about'     => 'static_pages#about'
  get 'contact'   => 'static_pages#contact'
  post 'message'   => 'static_pages#message'
  get 'error'     => 'static_pages#error'
  get 'signup'    => 'users#new'
  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  get 'search'    => 'business_cards#search'
  get 'more'      => 'business_cards#more'
  delete 'business_cards/:id' => 'business_cards#destroy'

  resources :users
  resources :pending_activations, only: [:index, :edit]
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]

  resources :business_cards, only: [:create, :edit, :update]
  resources :box_counts
  resources :dimensions
  resources :paper_types
  resources :coatings
  resources :quantities
  resources :metals
end
