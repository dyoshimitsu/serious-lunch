# frozen_string_literal: true

class Lunch < ActiveRecord::Base
  belongs_to :account
  default_scope -> { order(visit_date: :desc) }

  validates :account_id, presence: true
  validates :visit_date, presence: true
  validates :comment, length: { maximum: 255 }
end
