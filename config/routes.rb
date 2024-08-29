Rails.application.routes.draw do
  # mount ActionCable.server => '/cable'
  mount ActionCable.server => '/cable', constraints: { protocol: 'ws' }

  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"

  namespace :api do
    post 'login', to: 'session#create'
    post 'comments', to: 'comments#create'
    post 'entries', to: 'entries#create'
    get 'patients', to: 'patients#index'
    get 'patients/search', to: 'patients#search'
    post 'profiles', to: 'profiles#update'
    # post 'patients', to: 'patients#new'
  end

  # Ajax Filters
  get 'patients/filter', to: 'users#filter', as: :patients_filter
  get 'indicators/filter', to: 'indicators#filter', as: :indicators_filter
  get 'meals/filter', to: 'meals#filter', as: :meals_filter
  get 'conditions/filter', to: 'conditions#filter', as: :conditions_filter

  resources :activity_factors
  resources :contact_us
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
  resources :tasks
  resources :bmr_factors
  resources :conditions
  resources :meals
  resources :restricted_ingredient_conditions

  resources :diets
  post 'diets/session/:session_id', to: 'diets#create_diet_session', as: :create_diet_session

  get 'render_chat_partial/:id', to: 'conversations#render_chat_partial'
  resources :conversations do
    resources :notes
  end
  resources :entries do
    resources :emoji_reactions, only: [:create]

    resources :comments do
      resources :emoji_reactions, only: [:create]
    end
  end

  resources :billings do
    post '/billing_items/create', to: 'billing_items#create', as: :items_create
    # post '/paid_items/create', to: 'payments#create', as: :paid_items_create
    post '/payment/create', to: 'payments#create', as: :create_payment
    # get '/billing_items', to: 'billing_items#index', as: :items
    delete '/billing_items/:id', to: 'billing_items#destroy', as: :items_destroy
    # get '/billing_items/new', to: 'billing_items#new', as: :items_new
    post '/payments/create', to: 'payments#create', as: :payments_create
    delete '/payments/payment_items/:id', to: 'payment_billing_items#destroy', as: :payment_items_destroy
  end

  # get 'signup', to: 'users#new'
  # post 'signup', to: 'users#create'
  get 'login', to: 'authentication#login', as: :login
  post 'login', to: 'authentication#authenticate'
  delete 'logout', to: 'authentication#logout', as: :destroy_user_session

  post '/charts/sessionsjson', to: 'charts#sessionsjson'

  # global
  patch 'update_dolar_price/:id', to: 'application#update_dolar_price', as: :patch_update_dolar_price

  patch 'patients/:id', to: 'users#update', as: :patch_patient
  post 'patients', to: 'users#create', as: :post_patients
  post 'instant_patient/:id', to: 'users#create_from_instant', as: :create_patient_from_instant_session
  resources :patients, controller: 'users', type: 'User' do
    post '/patient_conditions', to: 'patient_conditions#create', as: :post_patient_conditions
    delete '/patient_conditions/:id', to: 'patient_conditions#destroy', as: :destroy_patient_conditions
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

  get "dashboard", to: "dashboard#index"
  root 'dashboard#index'
  # root 'examples#index'

  resources :examples, only: :index do
    get :buttons, :cards, :utilities_color, :utilities_border,
        :utilities_animation, :utilities_other,
        :forgot_password, :page_404, :blank, :charts, :tables,
        on: :collection
  end
end
