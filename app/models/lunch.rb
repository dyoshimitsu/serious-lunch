# frozen_string_literal: true

class Lunches < ActiveRecord::Base
  belongs_to :account
  default_scope -> { order(lunch_date: :desc) }

  validates :account_id, presence: true
  validates :lunch_date, presence: true
  validates :comment, length: { maximum: 255 }
end
