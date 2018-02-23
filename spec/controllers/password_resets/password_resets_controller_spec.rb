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
    before { patch :update, params: params }

    let(:password) { 'password' }
    let(:password_confirmation) { 'password' }

    let(:params) do
      {
        account:
            {
              password: password,
              password_confirmation: password_confirmation,
            },
      }

    end
  end
end
