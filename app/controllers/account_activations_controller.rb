# frozen_string_literal: true

class AccountActivationsController < ApplicationController

  def edit
    account = Account.find_by(email: params[:email])
    if account && !account.activated? && account.authenticated?(:activation, params[:id])
      account_update_attribute(account)
      log_in account
      flash[:success] = 'Account activated!'
      redirect_to short_account_url(account.account_name)
    else
      flash[:danger] = 'Invalid activation link'
      redirect_to root_url
    end
  end

  private

  def account_update_attribute(account)
    account.update_attribute(:activated, true)
    account.update_attribute(:activated_at, Time.zone.now)
  end
end
