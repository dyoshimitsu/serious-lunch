# frozen_string_literal: true

class AccountsController < ApplicationController

  def show
    @account = Account.find_by(account_name: params[:account_name])
  end
end
