# frozen_string_literal: true

class Account < ApplicationRecord
  VALID_EMAIL_ADDRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  has_many :lunches, dependent: :destroy
  has_many :active_account_relationships,
           class_name: 'AccountRelationship',
           foreign_key: 'follower_account_id',
           dependent: :destroy
  has_many :passive_account_relationships,
           class_name: 'AccountRelationship',
           foreign_key: 'followed_account_id',
           dependent:   :destroy
  has_many :following, through: :active_account_relationships, source: :followed_account
  has_many :followers, through: :passive_account_relationships, source: :follower_account
  has_one :account_activation, dependent: :destroy
  has_one :account_cookie, dependent: :destroy
  has_one :account_reset, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { email_address.downcase! }
  # before_create :create_activation_digest

  validates_with Validators::NonAccountNameValidator
  validates :account_name,
            presence: true,
            length: { maximum: 50 },
            format: { with: /\A[0-9a-zA-Z_]+\z/ },
            uniqueness: { case_sensitive: false }
  validates :password,
            presence: true,
            length: { minimum: 8 },
            allow_nil: true
  validates :email_address,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_ADDRESS_REGEX },
            uniqueness: { case_sensitive: false }

  def feed
    Lunch.where('account_id = ?', account_id)
  end
end
