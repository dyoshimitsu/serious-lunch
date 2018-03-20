# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LunchesController, :type => :controller do

  describe 'POST #create' do
    let(:action) { post :create, params: params }

    let(:lunch_date) { '2018-03-20' }
    let(:comment) { '' }
    let(:params) do
      {
        lunch:
        {
          lunch_date: lunch_date,
          comment: comment,
        },
      }
    end

    context 'when not logged in' do
      before { action }

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
        it 'create new lunch' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_url)
          expect(flash[:success]).not_to be_nil
          expect(account.lunches.count).to eq(1)
        end
      end

      context 'when parameter is invalid' do
        let(:lunch_date) { '' }

        it 'not create new lunch' do
          expect(response).to have_http_status(200)
          expect(flash[:success]).to be_nil
          expect(account.lunches.count).to eq(0)
        end
      end
    end
  end

  describe 'DELETE #destroy' do
    let(:action) { delete :destroy, params: params }

    let(:ate_lunch) { FactoryBot.create :account }
    let(:lunch) { FactoryBot.create(:lunch, account: ate_lunch) }
    let(:params) do
      {
        lunch_id: lunch.lunch_id,
      }
    end

    context 'when not logged in' do
      before { action }

      it 'should redirect' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_url)
      end
    end

    context 'when logged in' do
      include SessionsHelper

      before do
        log_in(ate_lunch)
        action
      end

      context 'when deleting the lunch of the logged in account' do
        it 'deleted lunch' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_url)
          expect(flash[:success]).not_to be_nil
          expect(ate_lunch.lunches.count).to eq(0)
        end
      end

      context 'when deleting the lunch of the not logged in account' do
        let(:not_ate_lunch) { FactoryBot.create :account }
        let(:lunch) { FactoryBot.create(:lunch, account: not_ate_lunch) }

        it 'not deleted lunch' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_url)
          expect(flash[:success]).to be_nil
          expect(not_ate_lunch.lunches.count).to eq(1)
        end
      end
    end
  end
end
