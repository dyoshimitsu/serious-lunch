# frozen_string_literal: true

require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do

  describe 'GET #home' do
    before { get :home }

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #about' do
    before { get :about }

    it { expect(response).to have_http_status(200) }
  end

  describe 'GET #hello' do
    before { get :hello }

    it { expect(response).to have_http_status(200) }
    it { expect(response.body).to eq('hello, world!') }
  end
end
