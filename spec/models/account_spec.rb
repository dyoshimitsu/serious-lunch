# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Account, type: :model do

  describe 'validation of account_name' do
    let(:validation) do
      account = FactoryBot.create :account
      account.account_name = account_name
      account
    end

    context 'when account_name is lower cace' do
      let(:account_name) { 'a' }

      it { expect(validation).to be_valid }
    end

    context 'when account_name is upper cace' do
      let(:account_name) { 'A' }

      it { expect(validation).to be_valid }
    end

    context 'when account_name is underscore' do
      let(:account_name) { '_' }

      it { expect(validation).to be_valid }
    end

    context 'when account_name is number' do
      let(:account_name) { '0' }

      it { expect(validation).to be_valid }
    end

    context 'when account_name is symbols other than underscore' do
      let(:account_name) { '@' }

      it { expect(validation).not_to be_valid }
    end

    context 'when account_name is empty' do
      let(:account_name) { '' }

      it { expect(validation).not_to be_valid }
    end
  end

  describe 'validation of password' do
    let(:validation) do
      account = FactoryBot.create :account
      account.password = password
      account
    end

    context 'When password is larger than minimum length' do
      let(:password) { 'a' * 8 }

      it { expect(validation).to be_valid }
    end

    context 'when password is minimum length' do
      let(:password) { 'a' * 7 }

      it { expect(validation).not_to be_valid }
    end
  end
end
