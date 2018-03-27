# frozen_string_literal: true

class Account::AccountMailer
  include Virtus.model

  attribute :account, Account, reader: :private

  def send_activation_email
    ::AccountMailer.account_activation(account).deliver_now
  end

  def send_password_reset_email
    ::AccountMailer.password_reset(account).deliver_now
  end
end
