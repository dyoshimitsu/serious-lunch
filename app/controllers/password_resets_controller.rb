# frozen_string_literal: true

class PasswordResetsController < ApplicationController
  before_action :valid_account, only: [:edit, :update]
  before_action :check_expiration, only: [:edit, :update]

  def create
    @account = Account.find_by(email: params[:password_reset][:email].downcase)
    if @account
      @account.create_reset_digest
      @account.send_password_reset_email
      flash[:info] = 'Email sent with password reset instructions'
      redirect_to root_url
    else
      flash.now[:danger] = 'Email address not found'
      render 'new'
    end
  end

  def update
    if params[:user][:password].empty?
      @account.errors.add(:password, :blank)
      render 'edit'
    elsif @account.update_attributes(user_params)
      log_in @account
      flash[:success] = 'Password has been reset.'
      redirect_to @account
    else
      render 'edit'
    end
  end

  private

  def valid_account
    @account = Account.find_by(email: params[:email])
    unless @account&.activated? &&
           @account.authenticated?(:reset, params[:id])
      redirect_to root_url
    end
  end

  def check_expiration
    return unless @account.password_reset_expired?
    flash[:danger] = 'Password reset has expired.'
    redirect_to new_password_reset_url
  end
end
