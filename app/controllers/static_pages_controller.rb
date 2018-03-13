# frozen_string_literal: true

class StaticPagesController < ApplicationController

  def hello
    render html: 'hello, world!'
  end

  def home
    @lunch = current_account.lunches.build if logged_in?
  end
end
