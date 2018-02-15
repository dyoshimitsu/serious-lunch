# frozen_string_literal: true

class AccountMailer < ApplicationMailer

  def account_activation(account)
    account = account
    mail to: account.email, subject: 'Account activation'
  end

  def password_reset
    @greeting = 'Hi'

    mail to: 'to@example.org'
  end
end
