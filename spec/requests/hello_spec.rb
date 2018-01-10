# frozen_string_literal: true

require 'rails_helper'

RSpec.describe '/hello', :type => :request do

  describe 'GET /hello' do
    before { get '/hello' }

    it { expect(response).to have_http_status(200) }
    it { expect(response.body).to eq('hello, world!') }
  end
end
