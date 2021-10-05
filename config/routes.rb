Rails.application.routes.draw do
    
  resources :activity_factors
  resources :roles
  resources :genders
  resources :indicator_types
  resources :indicators
  resources :packages


  resources :patients do

    # get '/sessions/sessionsjson', to: 'sessions#sessionsjson'
    get '/packages/:id/sessions/sessionsjson', to: 'patient_packages#sessionsjson'
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

 
  devise_for :users

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
