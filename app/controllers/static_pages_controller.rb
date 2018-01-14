# frozen_string_literal: true

class StaticPagesController < ApplicationController

  def hello
    render html: 'hello, world!'
  end
end
