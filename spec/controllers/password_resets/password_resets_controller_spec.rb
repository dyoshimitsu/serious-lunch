# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    before { post :create, params: params }

    let(:email) { '' }

    let(:params) do
      {
        password_reset:
            {
              email: email,
            },
      }
    end

    context 'when mail exist' do
      let(:account) { FactoryBot.create :account }
      let(:email) { account.email }

      it 'should reset_digest updated' do
        expect do
          account.reload
        end.to change{
          account.reset_digest.nil?
        }.from(true).to(false)
      end

      it 'should reset_sent_at updated' do
        expect do
          account.reload
        end.to change{
          account.reset_sent_at.nil?
        }.from(true).to(false)
      end

      it 'should be redirected to root' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
        expect(flash[:info]).not_to be_nil
      end
    end

    context 'when mail not exist' do
      it 'should flash danger' do
        expect(response).to have_http_status(200)
        expect(flash[:danger]).not_to be_nil
      end
    end
  end

  describe 'PATCH #update' do
    let(:action) { patch :update, params: params }

    let(:account) { FactoryBot.create :account }

    let(:reset_token) { account.reset_token }
    let(:email) { account.email }
    let(:password) { account.password }
    let(:password_confirmation) { password }

    let(:params) do
      {
        reset_token: reset_token,
        email: email,
        account:
            {
              password: password,
              password_confirmation: password_confirmation,
            },
      }
    end

    before do
      account.create_reset_digest
      action
    end

    context 'when email is empty' do
      let(:email) { '' }

      it 'should be redirected to root' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when account is not activated' do
      let(:account) { FactoryBot.create :account, activated: false }

      it 'should be redirected to root' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when reset_token is empty' do
      let(:reset_token) { '' }

      it 'should be redirected to root' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(root_url)
      end
    end

    context 'when password is empty' do
      let(:password) { '' }

      it 'should flash danger' do
        expect(response).to have_http_status(200)
        expect(account.errors[:password]).not_to be_nil
      end
    end
  end
end
