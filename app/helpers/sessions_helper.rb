# frozen_string_literal: true

module SessionsHelper

  def log_in(account)
    session[:account_id] = account.account_id
  end

  def current_account
    @current_account ||= Account.find_by(account_id: session[:account_id])
  end

  def logged_in?
    !current_account.nil?
  end
end
