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
  get 'signup'    => 'users#new'
  get 'login'     => 'sessions#new'
  post 'login'    => 'sessions#create'
  delete 'logout' => 'sessions#destroy'

  resources :users
  resources :account_activations, only: [:edit]
  resources :password_resets, only: [:new, :create, :edit, :update]
end
