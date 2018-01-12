# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AboutController, :type => :controller do

  describe 'GET #show' do
    before { get :show }

    it { expect(response).to have_http_status(200) }
  end
end
