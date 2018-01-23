# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    account = Account.find_by(email: params[:session][:email].downcase)
    if account&.authenticate(params[:session][:password])
      log_in account
      remember account
      redirect_to account_url(account.account_name)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
