# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    account = Account.find_by(email_address: params[:session][:email_address].downcase)
    account_authenticate(params, account)
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def account_authenticate(params, account)
    if account&.authenticate(params[:session][:password])
      account_activated?(account)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def account_activated?(account)
    if Account::AccountActivator.new(account: account).account_activated?
      log_in account
      account_remember(account)
      redirect_back_or short_account_url(account.account_name)
    else
      flash[:warning] = 'Account not activated. Check your email for the activation link.'
      redirect_to root_url
    end
  end

  def account_remember(account)
    if params[:session][:remember_me] == '1'
      remember(account)
    else
      forget(account)
    end
  end
end
