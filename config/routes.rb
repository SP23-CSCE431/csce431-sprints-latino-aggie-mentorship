Rails.application.routes.draw do

  resources :users
  #root 'users#index'
  root to: 'dashboards#show'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    post 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

  resources :mentors
  match 'mentor' => 'mentors#new', :via => [:post]

  resources :mentor do
    member do
      patch 'update'
    end
  end
  get 'leaderboard'=>'leader_board#index'
  get '/about', to: 'about#index' # This maps the "/about" path to the AboutController#index action
  get '/contact', to: 'contact#index' # This maps the "/contact" path to the ContactController#index action
  

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
