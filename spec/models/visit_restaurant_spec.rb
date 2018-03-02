# frozen_string_literal: true

require 'rails_helper'

RSpec.describe VisitRestaurant, type: :model do

  describe 'validation of comment' do
    let(:validation) do
      visit_restaurant = FactoryBot.create :visit_restaurant
      visit_restaurant.comment = comment
      visit_restaurant
    end

    context 'when comment is empty' do
      let(:comment) { '' }

      it { expect(validation).to be_valid }
    end

    context 'when comment is maximum length' do
      let(:comment) { 'あ' * 255 }

      it { expect(validation).to be_valid }
    end

    context 'when comment is larger than maximum length' do
      let(:comment) { 'あ' * 256 }

      it { expect(validation).not_to be_valid }
    end
  end
end
