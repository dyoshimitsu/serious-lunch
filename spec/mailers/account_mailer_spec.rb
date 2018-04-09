# frozen_string_literal: true

require 'rails_helper'

RSpec.describe AccountMailer, type: :mailer do
  describe 'account_activation' do
    let(:account) { FactoryBot.create :account }
    let(:mail) { AccountMailer.account_activation(account) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Account activation')
      expect(mail.to).to eq([account.email_address])
      expect(mail.from).to eq(['noreply@serious-lunch.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('Hi')
      expect(mail.body.encoded).to match(account.account_name)
      expect(mail.body.encoded).to match(CGI.escape(account.email_address))
    end
  end

  describe 'password_reset' do
    let(:account) { FactoryBot.create :account }
    let(:mail) do
      Account::AccountPasswordResetter.new(account: account).account_password_reset
      AccountMailer.password_reset(account)
    end

    it 'renders the headers' do
      expect(mail.subject).to eq('Password reset')
      expect(mail.to).to eq([account.email_address])
      expect(mail.from).to eq(['noreply@serious-lunch.com'])
    end

    it 'renders the body' do
      expect(mail.body.encoded).to match('will expire')
      expect(mail.body.encoded).to match(account.account_name)
      expect(mail.body.encoded).to match(CGI.escape(account.email_address))
    end
  end
end
