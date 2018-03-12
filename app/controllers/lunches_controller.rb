# frozen_string_literal: true

class LunchesController < ApplicationController
  before_action :logged_in_account, only: [:create, :destroy]

  def create
  end

  def destroy
  end
end
