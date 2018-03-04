# frozen_string_literal: true

class Account < ApplicationRecord
  VALID_EMAIL_ADDRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  has_many :visit_restaurants, dependent: :destroy

  attr_accessor :remember_token, :activation_token, :reset_token
  before_save { email_address.downcase! }
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
  validates :email_address,
            presence: true,
            length: { maximum: 255 },
            format: { with: VALID_EMAIL_ADDRESS_REGEX },
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

  def authenticated?(attribute, token)
    digest = send("#{attribute}_digest")
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  def activate
    update_columns(activated: true, activated_at: Time.zone.now)
  end

  def send_activation_email
    AccountMailer.account_activation(self).deliver_now
  end

  def create_reset_digest
    self.reset_token = Account.new_token
    update_columns(reset_digest: Account.digest(reset_token),
                   reset_sent_at: Time.zone.now)
  end

  def send_password_reset_email
    AccountMailer.password_reset(self).deliver_now
  end

  def password_reset_expired?
    reset_sent_at < 30.minutes.ago
  end

  private

  def create_activation_digest
    self.activation_token = Account.new_token
    self.activation_digest = Account.digest(activation_token)
  end
end
