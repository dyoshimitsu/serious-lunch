# frozen_string_literal: true

module SessionsHelper

  def log_in(account)
    session[:account_id] = account.account_id
  end

  def remember(account)
    Account::AccountRemember.new(account: account).account_remember
    cookies.permanent.signed[:account_id] = account.account_id
    cookies.permanent[:remember_token] = account.remember_token
  end

  def current_account?(account)
    account == current_account
  end

  def current_account
    if (account_id = session[:account_id])
      @current_account ||= Account.find_by(account_id: account_id)
    elsif (account_id = cookies.signed[:account_id])
      account = Account.find_by(account_id: account_id)
      if Account::AccountAuthenticator.new(account: account)
                                      .remember_authenticated?(params[:remember_token])
        log_in account
        @current_account = account
      end
    end
  end

  def logged_in?
    !current_account.nil?
  end

  def forget(account)
    Account::AccountRemember.new(account: account).account_forget
    cookies.delete(:account_id)
    cookies.delete(:remember_token)
  end

  def log_out
    forget(current_account)
    session.delete(:account_id)
    @current_account = nil
  end

  def redirect_back_or(default)
    redirect_to(session[:forwarding_url] || default)
    session.delete(:forwarding_url)
  end

  def store_location
    session[:forwarding_url] = request.original_url if request.get?
  end
end
