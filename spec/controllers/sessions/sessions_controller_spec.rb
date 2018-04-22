# frozen_string_literal: true

require 'rails_helper'

RSpec.describe SessionsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    before { post :create, params: params }

    let(:account) { FactoryBot.create :account, :with_account_activation }
    let(:email_address) { account.email_address }
    let(:password) { account.password }

    let(:params) do
      {
        session:
        {
          email_address: email_address,
          password: password,
        },
      }
    end

    context 'when parameter is valid' do
      context 'when account is not activated' do
        let(:account) { FactoryBot.create :account }

        it 'fail in login' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_url)
          expect(flash[:warning]).not_to be_nil
        end
      end

      context 'when account is activated' do
        it 'success in login' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(short_account_url(account.account_name))
          expect(flash[:warning]).to be_nil
        end
      end
    end

    context 'when the account does not exist' do
      let(:email_address) { 'bar@example.com' }

      it 'fail in login' do
        expect(response).to have_http_status(200)
        expect(flash[:danger]).not_to be_nil
      end
    end

    context 'when password does not match' do
      let(:password) { 'password!' }

      it 'fail in login' do
        expect(response).to have_http_status(200)
        expect(flash[:danger]).not_to be_nil
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy }

    it 'success in logout' do
      expect(response).to have_http_status(302)
      expect(response).to redirect_to(root_url)
    end
  end
end
