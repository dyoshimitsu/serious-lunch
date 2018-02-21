# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
  end

  describe 'PATCH #update' do
  end

end
