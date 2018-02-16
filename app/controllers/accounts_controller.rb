# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :logged_in_account, only: [:index, :edit, :update]

  def new
    @account = Account.new
  end

  def index
    @accounts = Account.paginate(page: params[:page]).order(:account_name)
  end

  def show
    @account = Account.find_by(account_name: params[:account_name])
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      @account.send_activation_email
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @account = Account.find(params[:account_id])
    if @account != current_account
      redirect_to(root_url)
    elsif @account.update_attributes(account_params)
      flash[:success] = 'Profile updated'
      redirect_to short_account_url(@account.account_name)
    else
      render 'edit'
    end
  end

  def edit
    @account = Account.find_by(account_name: params[:account_name])
    redirect_to(root_url) unless @account == current_account
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
    store_location
    flash[:danger] = 'Please log in.'
    redirect_to login_url
  end
end
