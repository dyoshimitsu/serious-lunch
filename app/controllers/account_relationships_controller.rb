# frozen_string_literal: true

class AccountRelationshipsController < ApplicationController
  before_action :logged_in_account

  def create
    account = Account.find(params[:followed_account_id])
    Account::AccountFollower.new(account: current_account).follow(account)
    respond_to do |format|
      format.html { redirect_to(short_account_url(account.account_name)) }
      format.js
    end
  end

  def destroy
    account = AccountRelationship.find(params[:account_relationship_id]).followed_account
    Account::AccountFollower.new(account: current_account).unfollow(account)
    respond_to do |format|
      format.html { redirect_to(short_account_url(account.account_name)) }
      format.js
    end
  end
end
