# frozen_string_literal: true

require 'rails_helper'

RSpec.describe LunchesController, :type => :controller do

  describe 'POST #create' do
    let(:action) { post :create }

    context 'when not logged in' do
      before { action }

      it 'should redirect' do
        expect(response).to have_http_status(302)
        expect(response).to redirect_to(login_url)
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
