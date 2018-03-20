# frozen_string_literal: true

class LunchesController < ApplicationController
  before_action :logged_in_account, only: [:create, :destroy]

  def create
    @lunch = current_account.lunches.build(lunch_params)
    if @lunch.save
      flash[:success] = 'Had Lunch!'
      redirect_to root_url
    else
      @feed_items = []
      render 'static_pages/home'
    end
  end

  def destroy
    lunche = current_account.lunches.find_by(lunch_id: params[:lunch_id])
    redirect_to root_url if lunche.nil?

    lunche.destroy
    flash[:success] = 'Lunch deleted'
    redirect_back(fallback_location: root_url)
  end

  private

  def lunch_params
    params.require(:lunch).permit(
      :lunch_date,
      :comment
    )
  end
end
