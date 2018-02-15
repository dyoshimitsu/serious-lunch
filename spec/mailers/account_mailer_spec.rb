# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountMailer, type: :mailer do
  describe 'account_activation' do
    let(:account) { FactoryBot.create :account }
    let(:mail) { AccountMailer.account_activation(account) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Account activation')
      expect(mail.to).to eq([account.email])
      expect(mail.from).to eq(['noreply@serious-lunch.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
    end
  end
end
