# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    account = Account.find_by(email: params[:session][:email].downcase)
    account_authenticate(params, account)
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end

  private

  def account_authenticate(params, account)
    if account&.authenticate(params[:session][:password])
      if account.activated?
        log_in account
        params[:session][:remember_me] == '1' ? remember(account) : forget(account)
        redirect_back_or short_account_url(account.account_name)
      else
        flash[:warning] =
          'Account not activated. Check your email for the activation link.'
        redirect_to root_url
      end
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
