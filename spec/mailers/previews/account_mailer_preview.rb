# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/account_mailer
class AccountMailerPreview < ActionMailer::Preview

  # Preview this email at
  # http://localhost:3000/rails/mailers/account_mailer/account_activation
  def account_activation
    account = Account.first
    account.activation_token = Account.new_token
    AccountMailer.account_activation(account)
  end

  # Preview this email at
  # http://localhost:3000/rails/mailers/account_mailer/password_reset
  def password_reset
    AccountMailer.password_reset
  end
end
