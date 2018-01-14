# frozen_string_literal: true

Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root controller: :static_pages, action: :home
  resource :home, only: [:show], controller: :static_pages, action: :home
  resource :about, only: [:show], controller: :static_pages, action: :about
  resource :signup, only: [:show], controller: :static_pages, action: :signup

  resource :hello, only: [:show], controller: :static_pages, action: :hello
end
