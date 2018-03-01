# frozen_string_literal: true

class VisitRestaurant < ActiveRecord::Base
  belongs_to :account

  validates :account_id, presence: true
  validates :comment, presence: true, length: { maximum: 255 }
end
