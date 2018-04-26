# frozen_string_literal: true

# rubocop:disable Style/FormatStringToken

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resource :hello, only: [:show], controller: :static_pages, action: :hello

  root controller: :static_pages, action: :home
  resource :home, only: [:show], controller: :static_pages, action: :home
  resource :about, only: [:show], controller: :static_pages, action: :about

  get '/signup', controller: :accounts, action: :new
  post '/signup', controller: :accounts, action: :create

  get '/login', controller: :sessions, action: :new
  post '/login', controller: :sessions, action: :create
  delete '/logout', controller: :sessions, action: :destroy

  resources :account_activations, param: :activation_token, only: [:edit]
  resources :password_resets, param: :reset_token, only: [:new, :create, :edit, :update]

  resources :lunches, only: [:create, :destroy], param: :lunch_id

  get '/users', controller: :accounts, action: :index
  resources :accounts, only: [:update], param: :account_id
  resources :accounts, only: [:edit], param: :account_name do
    member do
      get :following, :followers
    end
  end
  resources :account_relationships, only: [:create, :destroy], param: :account_id
  get '/accounts/:account_name', controller: :accounts, action: :show,
                                 to: redirect('/%{account_name}')
  get '/:account_name', controller: :accounts, action: :show, as: :short_account
end

# rubocop:enable Style/FormatStringToken
