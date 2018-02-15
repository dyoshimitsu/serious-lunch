# frozen_string_literal: true

class Account < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password

  attr_accessor :remember_token, :activation_token
  before_save { email.downcase! }
  before_create :create_activation_digest

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
  validates :email,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }

  def self.digest(string)
    cost =
      if ActiveModel::SecurePassword.min_cost
        BCrypt::Engine::MIN_COST
      else
        BCrypt::Engine.cost
      end
    BCrypt::Password.create(string, cost: cost)
  end

  def self.new_token
    SecureRandom.urlsafe_base64
  end

  def remember
    self.remember_token = Account.new_token
    update_attribute(:remember_digest, Account.digest(remember_token))
  end

  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private

  def create_activation_digest
    self.activation_token  = Account.new_token
    self.activation_digest = Account.digest(activation_token)
  end
end
