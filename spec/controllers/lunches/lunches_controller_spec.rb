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
        it 'should redirect to root' do
          expect(response).to have_http_status(302)
          expect(response).to redirect_to(root_url)
          expect(flash[:success]).not_to be_nil
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

    let(:lunch) { FactoryBot.create :lunch }
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
  end
end
