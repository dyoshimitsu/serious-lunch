# frozen_string_literal: true

class VisitRestaurant < ActiveRecord::Base
  belongs_to :account
  default_scope -> { order(created_at: :desc) }

  validates :account_id, presence: true
  validates :comment, length: { maximum: 255 }
end
