# frozen_string_literal: true

module SessionsHelper

  def log_in(account)
    session[:account_id] = account.account_id
  end
end
