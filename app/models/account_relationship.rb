# frozen_string_literal: true

class AccountRelationship < ApplicationRecord
  belongs_to :follower_account, class_name: 'Account'
  belongs_to :followed_account, class_name: 'Account'

  validates :follower_account_id, presence: true
  validates :followed_account_id, presence: true
end
