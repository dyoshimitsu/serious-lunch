# frozen_string_literal: true

require 'rails_helper'

RSpec.describe HomeController, :type => :controller do

  describe 'GET #index' do
    before { get :index }

    it { expect(response).to have_http_status(200) }
  end
end
