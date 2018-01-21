# frozen_string_literal: true

class SessionsController < ApplicationController

  def create
    account = Account.find_by(email: params[:session][:email].downcase)
    if account&.authenticate(params[:session][:password])
      log_in account
      redirect_to account_url(@account.account_name)
    else
      flash.now[:danger] = 'Invalid email/password combination'
      render 'new'
    end
  end
end
