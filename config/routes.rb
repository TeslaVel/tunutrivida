Rails.application.routes.draw do
  
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  devise_for :users

  namespace :api do
    post 'login', to: 'session#create'
    get 'patients', to: 'patients#index'
    get 'patients/search', to: 'patients#search'
    post 'patients', to: 'patients#new'
  end

  resources :activity_factors
  resources :roles
  resources :genders
  resources :discounts
  resources :products
  resources :indicator_types
  resources :indicators
  resources :packages
  resources :instant_sessions
  resources :appointments
  resources :availabilities

  resources :billings do
    post '/billing_items/create', to: 'billing_items#create', as: :items_create
    post '/paid_items/create', to: 'payments#create', as: :paid_items_create
    get '/billing_items/new', to: 'billing_items#new', as: :items
    delete '/billing_items/:id', to: 'billing_items#destroy', as: :items_destroy
    post '/payments/create', to: 'payments#create', as: :payments_create
    delete '/payments/payment_items/:id', to: 'payment_billing_items#destroy', as: :payment_items_destroy
  end


  get 'patients/search', to: 'patients#search', as: :patients_search
  resources :patients do
    get '/packages/:id/sessions/sessionsjson', to: 'patient_packages#sessionsjson'
    get '/packagesjson', to: 'patient_packages#packagesjson'
    #PACKAGES
    get '/patient_packages/new', to: 'patient_packages#new', as: :package_new
    get '/patient_packages/:id', to: 'patient_packages#show', as: :package_show
    post '/patient_packages/create', to: 'patient_packages#create', as: :package_create

    resources :patient_packages do
      get '/sessions/new', to: 'sessions#new', as: :new_session
      get '/sessions/:id', to: 'sessions#show', as: :session_show
      get '/sessions/:id/edit', to: 'sessions#edit', as: :edit_session
      patch '/session/:id/update', to: 'sessions#update', as: :update_session
      post '/sessions/create', to: 'sessions#create', as: :create_session
    end

  end

  # scope module: 'web' do
      # post 'launcher/launch', action: 'launch', controller: 'launcher'
  # end
  # , :controllers => {:sessions => "sessions"}, skip:[:sessions]
  # as :users do
  #   get 'users/sign_in' => 'devise/sessions#new', :as => :new_user_session
  #   # post 'login' => 'devise/sessions#create', :as => :user_session
  #   # delete 'signout' => 'devise/sessions#destroy', :as => :destroy_user_session
  # end

  root 'examples#index'

  resources :examples, only: :index do
    get :buttons, :cards, :utilities_color, :utilities_border,
        :utilities_animation, :utilities_other, :login, :register,
        :forgot_password, :page_404, :blank, :charts, :tables,
        on: :collection
  end
end
