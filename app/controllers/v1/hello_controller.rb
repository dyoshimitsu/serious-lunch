# frozen_string_literal: true

class V1::HelloController < ApplicationController

  def show
    render html: 'hello, world!'
  end
end
