# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    before { post :create, params: params }

    let(:account_name) { 'foo' }
    let(:email) { 'foo@example.com' }
    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    let(:params) do
      {
        account:
        {
          account_name: account_name,
          email: email,
          password: password,
          password_confirmation: password_confirmation,
        },
      }
    end

    context 'when parameter is valid' do
      it 'create new account' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(account_url(account_name))
        expect(Account.count).to eq(1)
      end
    end

    context 'when password confirmation does not match' do
      let(:password_confirmation) { 'password!' }

      it 'not create new account' do
        expect(response).to have_http_status(200)
        expect(Account.count).to eq(0)
      end
    end
  end
end
