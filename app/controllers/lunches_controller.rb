# frozen_string_literal: true

class LunchesController < ApplicationController
  before_action :logged_in_account, only: [:create, :destroy]

  def create
    @lunch = current_account.lunches.build(lunch_params)
    if @lunch.save
      flash[:success] = 'Had Lunch!'
      redirect_to root_url
    else
      render 'static_pages/home'
    end
  end

  def destroy
  end
end
