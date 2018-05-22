# frozen_string_literal: true

class AccountRelationshipsController < ApplicationController
  before_action :logged_in_account

  def create
    account = Account.find_by(account_id: params[:followed_account_id])
    if account && account != current_account
      Account::AccountFollower.new(account: current_account).follow(account)
      redirect_to(short_account_url(account.account_name))
    else
      render file: Rails.root.join('public/404.html'),
             status: 404,
             layout: false,
             content_type: 'text/html'
    end
  end

  def destroy
    account = AccountRelationship.find(params[:account_relationship_id]).followed_account
    Account::AccountFollower.new(account: current_account).unfollow(account)
    redirect_to(short_account_url(account.account_name))
  end
end
