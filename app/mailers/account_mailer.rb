# frozen_string_literal: true

class AccountMailer < ApplicationMailer

  def account_activation(account)
    @account = account
    mail to: account.email_address, subject: 'Account activation'
  end

  def password_reset(account)
    @account = account
    mail to: account.email_address, subject: 'Password reset'
  end
end
