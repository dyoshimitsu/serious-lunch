# frozen_string_literal: true

class StaticPagesController < ApplicationController

  def hello
    render html: 'hello, world!'
  end

  def home
    return unless logged_in?
    @lunch = current_account.lunches.build
    @feed_items = current_account.feed.paginate(page: params[:page])
  end
end
