# frozen_string_literal: true

class HelloController < ApplicationController

  def show
    render html: 'hello, world!'
  end
end
