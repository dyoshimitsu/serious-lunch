# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :valid_account, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def create
    account = Account.find_by(
      email_address: params[:password_reset][:email_address].downcase
    )
    if account
      Account::AccountPasswordResetter.new(account: account).account_password_reset
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def update
    if params[:account][:password].empty?
      @account.errors.add(:password, :blank)
      render 'edit'
    elsif @account.update_attributes(account_params)
      log_in @account
      AccountReset.delete(account_id: @account)
      flash[:success] = 'Password has been reset.'
      redirect_to short_account_url(@account.account_name)
    else
      render 'edit'
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :password,
      :password_confirmation
    )
  end

  def valid_account
    @account ||= Account.find_by(email_address: params[:email_address])
    unless Account::AccountActivator.new(account: @account).account_activated? &&
           Account::AccountAuthenticator.new(
             account: @account
           ).reset_authenticated?(params[:reset_token])
      redirect_to root_url
    end
  end

  def check_expiration
    @account ||= Account.find_by(email_address: params[:email_address])
    return unless Account::AccountPasswordResetter.new(
      account: @account
    ).password_reset_expired?
    flash[:danger] = 'Password reset has expired.'
    redirect_to new_password_reset_url
  end
end
