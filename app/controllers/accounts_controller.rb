# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :logged_in_account, only: [:edit, :update]

  def new
    @account = Account.new
  end

  def show
    @account = Account.find_by(account_name: params[:account_name])
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      log_in @account
      flash[:success] = 'Welcome to the Serious Lunch!'
      redirect_to short_account_url(@account.account_name)
    else
      render 'new'
    end
  end

  def update
    @account = Account.find(params[:account_id])
    if @account.update_attributes(account_params)
      flash[:success] = 'Profile updated'
      redirect_to short_account_url(@account.account_name)
    else
      render 'edit'
    end
  end

  def edit
    @account = Account.find_by(account_name: params[:account_name])
  end

  private

  def account_params
    params.require(:account).permit(
      :account_name,
      :email,
      :password,
      :password_confirmation
    )
  end

  def logged_in_account
    return if logged_in?
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
