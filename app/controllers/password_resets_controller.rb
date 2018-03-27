# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :valid_account, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def create
    account = Account.find_by(
      email_address: params[:password_reset][:email_address].downcase
    )
    if account
      account.create_reset_digest
      account.send_password_reset_email
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
      @account.update_attribute(:reset_digest, nil)
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
    @account = Account.find_by(email_address: params[:email_address])
    unless @account&.activated? &&
           @account.authenticated?(:reset, params[:reset_token])
      redirect_to root_url
    end
  end

  def check_expiration
    return unless @account.password_reset_expired?
    flash[:danger] = 'Password reset has expired.'
    redirect_to new_password_reset_url
  end
end
