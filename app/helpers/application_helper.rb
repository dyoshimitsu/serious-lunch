# frozen_string_literal: true

module ApplicationHelper

  def dynamic_title(page_title = '')
    base_title = 'Serious Lunch'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end
end
