Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

 resources :patients
  resources :roles
  resources :genders

  devise_for :users
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
