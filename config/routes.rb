Rails.application.routes.draw do
  resources :courses
  resources :users
  resources :user
  resources :consultations
  resources :user_events
  #root 'users#index'

  get "pages", to: "pages#calendar", as: :pages
  get '/check_string', to: 'users#check_string'
  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    post 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
