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
      # 保存の成功をここで扱う。
    else
      render 'new'
    end
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
