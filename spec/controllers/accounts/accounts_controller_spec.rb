# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(200) }
  end
end
