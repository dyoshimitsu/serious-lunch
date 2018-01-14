# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root controller: :home, action: :show
  resource :home, only: [:show], controller: 'home'
  resource :about, only: [:show], controller: 'about'
  resource :signup, only: [:show], controller: 'signup'

  resource :hello, only: [:show], controller: 'hello'
end
