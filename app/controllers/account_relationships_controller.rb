# frozen_string_literal: true

class AccountRelationshipsController < ApplicationController
  before_action :logged_in_account

  def create
    account = Account.find(params[:followed_account_id])
    current_account.follow(account)
    redirect_to account
  end
end
