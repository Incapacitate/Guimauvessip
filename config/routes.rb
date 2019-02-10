Rails.application.routes.draw do
  #static pages
  get 'welcome/:user_entry', to: 'welcome#show'
  # get 'team', to: 'static_pages#team'
  # get 'contact', to: 'static_pages#contact'
  resources :teams, only: [:index]
  resources :contacts, only: [:index]


  root 'static_pages#index'

  resources :gossips do
    resources :comments
    resources :likes
  end

  resources :users
  resources :cities

  resources :sessions, only: [:new, :create, :destroy]

  resources :conversations do
    resources :messages
  end
end
