# frozen_string_literal: true

class AccountActivationsController < ApplicationController

  def edit
    account = Account.find_by(email_address: params[:email_address])
    activator = Account::AccountActivator.new(account: account)
    if account &&
       !activator.account_activated? &&
       Account::AccountAuthenticator.new(
         account: account
       ).activation_authenticated?(params[:activation_token])
      activator.account_activate
      log_in account
      flash[:success] = 'Account activated!'
      redirect_to short_account_url(account.account_name)
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end
end
