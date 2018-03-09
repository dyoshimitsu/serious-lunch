# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Lunch, type: :model do

  describe 'validation of comment' do
    let(:validation) do
      lunch = FactoryBot.create :lunch
      lunch.comment = comment
      lunch
    end

    context 'when comment is nil' do
      let(:comment) { nil }

      it { expect(validation).to be_valid }
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

  describe 'validation of lunch_date' do
    let(:validation) do
      lunch = FactoryBot.create :lunch
      lunch.visit_date = visit_date
      lunch
    end

    context 'when lunch_date is nil' do
      let(:lunch_date) { nil }

      it { expect(validation).not_to be_valid }
    end

    context 'when lunch_date is empty' do
      let(:lunch_date) { '' }

      it { expect(validation).not_to be_valid }
    end
  end
end
