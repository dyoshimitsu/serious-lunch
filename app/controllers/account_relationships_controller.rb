# frozen_string_literal: true

class AccountRelationshipsController < ApplicationController
  before_action :logged_in_account

  def create
    account = Account.find(params[:followed_account_id])
    current_account.follow(account)
    redirect_to account
  end

  def destroy
    account = AccountRelationship.find(params[:account_relationship_id]).followed_account
    current_account.unfollow(account)
    redirect_to account
  end
end
