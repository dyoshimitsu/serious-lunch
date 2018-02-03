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
        expect(response).to redirect_to(short_account_url(account_name))
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

  describe 'PATCH #update' do
    before { patch :update, params: params }

    let(:account) { FactoryBot.create :account }
    let(:account_id) { account.account_id }

    let(:account_name) { account.account_name }
    let(:email) { account.email }
    let(:password) { account.password }
    let(:password_confirmation) { account.password }

    let(:params) do
      {
        account_id: account_id,
        account:
        {
          account_name: account_name,
          email: email,
          password: password,
          password_confirmation: password_confirmation,
        },
      }
    end

    context 'when updating account_name' do
      let(:account_name) { 'bar' }

      it 'account is updated' do
        expect(response).to have_http_status(302)
        expect(account.reload.account_name).to eq(account_name)
      end
    end

    context 'when updating email' do
      let(:email) { 'bar@example.com' }

      it 'account is updated' do
        expect(response).to have_http_status(302)
        expect(account.reload.email).to eq(email)
      end
    end

    context 'when updating password' do
      let(:password) { 'password!' }
      let(:password_confirmation) { 'password!' }

      it 'account is updated' do
        expect(response).to have_http_status(302)
        expect(account.reload.password).to eq(password)
      end
    end

    context 'when password confirmation does not match' do
      let(:password_confirmation) { 'password!' }

      it 'account is not updated' do
        expect(response).to have_http_status(200)
        expect(account.reload.password).to eq(password)
      end
    end
  end
end
