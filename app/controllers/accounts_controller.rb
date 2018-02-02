# frozen_string_literal: true

class AccountsController < ApplicationController

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
    @account = Account.find(params[:id])
    if @account.update_attributes(account_params)
      flash[:success] = 'Profile updated'
      redirect_to @account
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
end
