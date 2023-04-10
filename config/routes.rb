Rails.application.routes.draw do
  resources :hobbies
  root to: 'dashboards#show'
  resources :courses
  resources :users do
    post :add_hours, on: :member
  end
  resources :consultations do
    member do
      post :check_code
    end
  end
  resources :user_events

  get "/leader", to: "leader#index"
  get "/leaderMentor", to: "leader#leaderMentor"
  get "/search", to: "users#search"
  get "/log_hours", to: "users#log_hours", as: :add_hours
  get "/add_course", to: "users#add_course", as: :add_courses
  get "/add_hobby", to: "users#add_hobby", as: :add_hobbies
  get "/pages", to: "pages#calendar", as: :pages
  get "/faq", to: "dashboards#faq", as: :faq
  get '/check_string', to: 'users#check_string'
  devise_for :admins, controllers: { omniauth_callbacks: 'admins/omniauth_callbacks' }
  devise_scope :admin do
    get 'admins/sign_in', to: 'admins/sessions#new', as: :new_admin_session
    post 'admins/sign_out', to: 'admins/sessions#destroy', as: :destroy_admin_session
  end

end
