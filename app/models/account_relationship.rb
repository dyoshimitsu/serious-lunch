# frozen_string_literal: true

class AccountRelationship < ApplicationRecord
  belongs_to :follower_account, class_name: 'Account'
  belongs_to :followed_account, class_name: 'Account'
end
