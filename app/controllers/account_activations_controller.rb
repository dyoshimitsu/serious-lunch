# frozen_string_literal: true

class AccountActivationsController < ApplicationController

  def edit
    account = Account.find_by(email_address: params[:email_address])
    if account &&
       !account.account_activation.activated? &&
       account.account_activation.authenticated?(params[:activation_token])
      account.account_activation.activate
      log_in account
      flash[:success] = 'Account activated!'
      redirect_to short_account_url(account.account_name)
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
