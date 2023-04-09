Rails.application.routes.draw do
  resources :courses
  resources :users do
    post :add_hours, on: :member
  end
  resources :consultations do
    member do
      post :check_code
    end
  end
  resources :consultations
  resources :user_events
  #root 'users#index'

  get "/search", to: "users#search"
  get "/log_hours", to: "users#log_hours", as: :add_hours
  get "/add_course", to: "users#add_course", as: :add_courses
  get "/pages", to: "pages#calendar", as: :pages
  get '/check_string', to: 'users#check_string'
  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    post 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  #post "mentor" => "mentors#create"

  #resources :mentors, only: [:index, :create]

  # resources :mentor do
  #   member do
  #     patch 'update'
  #   end
  # end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
