# frozen_string_literal: true

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

  resources :accounts, only: [:show], param: :account_name
  get '/:account_name', controller: :accounts, action: :show
end
