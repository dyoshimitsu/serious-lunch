# frozen_string_literal: true

require 'rails_helper'

RSpec.describe PasswordResetsController, :type => :controller do

  describe 'GET #new' do
    before { get :new }

    it { expect(response).to have_http_status(200) }
  end

  describe 'POST #create' do
    before { post :create, params: params }

    let(:email_address) { '' }

    let(:params) do
      {
        password_reset:
            {
              email_address: email_address,
            },
      }
    end

    context 'when mail exist' do
      let(:account) { FactoryBot.create :account }
      let(:email_address) { account.email_address }

      it 'should reset_digest updated' do
        # expect do
        #   account.account_reset.reload
        # end.to change{
        #   account.reset_digest.nil?
        # }.from(true).to(false)
        expect(account.account_reset.reset_digest).not_to be_nil
      end

      # it 'should reset_sent_at updated' do
      #   expect do
      #     account.reload
      #   end.to change{
      #     account.reset_sent_at.nil?
      #   }.from(true).to(false)
      # end

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

    let(:create_reset_digest) do
      Account::AccountPasswordResetter.new(account: account).account_password_reset
    end

    let(:reset_token) { account.reset_token }
    let(:email_address) { account.email_address }
    let(:password) { account.password }
    let(:password_confirmation) { password }

    let(:params) do
      {
        reset_token: reset_token,
        email_address: email_address,
        account:
            {
              password: password,
              password_confirmation: password_confirmation,
            },
      }
    end

    before do
      create_reset_digest
      action
    end

    context 'when email_address is empty' do
      let(:email_address) { '' }

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

    context 'when 30 minutes have passed since send of reset token' do
      let(:create_reset_digest) do
        account.create_reset_digest
        account.reset_sent_at -= 30.minutes
        account.save
      end

      it 'should be redirected to new_password_reset_url' do
        expect(response).to have_http_status(302)
        expect(flash[:danger]).not_to be_nil
        expect(response).to redirect_to(new_password_reset_url)
      end
    end

    context 'when password is empty' do
      let(:password) { '' }

      it 'should flash danger' do
        expect(response).to have_http_status(200)
        expect(account.errors[:password]).not_to be_nil
      end
    end

    context 'when password confirmation does not match' do
      let(:password) { 'password!' }
      let(:password_confirmation) { 'password' }

      it 'account is not updated' do
        expect(response).to have_http_status(200)
        expect(flash[:success]).to be_nil
        expect(account.reload.authenticate(password)).to eq(false)
      end
    end

    context 'when reset password' do
      it 'account is updated' do
        expect(response).to have_http_status(302)
        expect(flash[:success]).not_to be_nil
        expect(account.reload.authenticate(password)).not_to eq(false)
      end
    end
  end
end
