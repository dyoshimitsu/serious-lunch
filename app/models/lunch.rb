# frozen_string_literal: true

class Lunch < ActiveRecord::Base
  belongs_to :account

  validates :account_id, presence: true
  validates :lunch_date, presence: true
  validates :comment, length: { maximum: 255 }
end
