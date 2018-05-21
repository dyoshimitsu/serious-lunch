# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountRelationshipsController, :type => :controller do

  describe 'POST #create' do
    let(:action) { post :create, params: params }
    let(:followed_account) { FactoryBot.create :account }

    let(:params) do
      {
        followed_account_id: followed_account_id,
      }
    end

    context 'when not logged in' do
      before { action }
      let(:followed_account_id) { followed_account.account_id }

      it 'should redirect to login' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_url)
      end
    end

    context 'when logged in' do
      include SessionsHelper

      let(:account) { FactoryBot.create :account }
      before do
        log_in(account)
        action
      end

      context 'when parameter is valid' do
        let(:followed_account_id) { followed_account.account_id }

        it 'create new account_relationship' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(short_account_url(followed_account.account_name))
          expect(account.following.count).to eq(1)
          expect(followed_account.followers.count).to eq(1)
        end
      end

      context 'when parameter is invalid' do
        context 'when parameter is does not exist' do
          let(:followed_account_id) { 'invalid' }

          it 'not create new account_relationship' do
            expect(account.following.count).to eq(0)
            expect(followed_account.followers.count).to eq(0)
          end

          context 'when parameter is itself' do
            let(:followed_account_id) { account.account_id }

            it 'not create new account_relationship' do
              expect(account.following.count).to eq(0)
              expect(followed_account.followers.count).to eq(0)
            end
          end
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:action) { delete :destroy, params: params }

    let(:params) do
      {
        account_relationship_id: account_relationship_id,
      }
    end
  end
end
