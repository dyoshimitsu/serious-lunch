# frozen_string_literal: true

class AccountsController < ApplicationController
  before_action :logged_in_account, only: [:index, :edit, :update, :following, :followers]

  def new
    @account = Account.new
  end

  def index
    @accounts = Account.left_outer_joins(:account_activation)
                       .where(account_activations: { activated: true })
                       .paginate(page: params[:page])
                       .order(:account_name)
  end

  def show
    @account = Account.find_by(account_name: params[:account_name])
    if @account
      @lunches = @account.lunches
                         .order(lunch_date: :desc)
                         .paginate(page: params[:page])
    else
      render file: Rails.root.join('public/404.html'),
             status: 404,
             layout: false,
             content_type: 'text/html'
    end
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      Account::AccountActivator.new(account: @account).account_activation
      flash[:info] = 'Please check your email to activate your account.'
      redirect_to root_url
    else
      render 'new'
    end
  end

  def update
    @account = Account.find(params[:account_id])
    if @account != current_account
      redirect_to root_url
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

  def following
    @title = 'Following'
    @account = Account.find_by(account_name: params[:account_name])
    if @account
      @accounts = @account.following.paginate(page: params[:page])
      render 'show_follow'
    else
      render file: Rails.root.join('public/404.html'),
             status: 404,
             layout: false,
             content_type: 'text/html'
    end
  end

  def followers
    @title = 'Followers'
    @account = Account.find_by(account_name: params[:account_name])
    if @account
      @accounts = @account.followers.paginate(page: params[:page])
      render 'show_follow'
    else
      render file: Rails.root.join('public/404.html'),
             status: 404,
             layout: false,
             content_type: 'text/html'
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :account_name,
      :email_address,
      :password,
      :password_confirmation
    )
  end
end
