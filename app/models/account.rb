# frozen_string_literal: true

class Account < ApplicationRecord
  VALID_EMAIL_ADDRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_secure_password
  has_many :lunches, dependent: :destroy
  has_one :account_activation, dependent: :destroy
  has_one :account_remember, dependent: :destroy
  has_one :account_reset, dependent: :destroy

  before_save { email_address.downcase! }

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

  def remember
    self.remember_token = Account.new_token
    update_attribute(:remember_digest, Account.digest(remember_token))
  end

  def forget
    update_attribute(:remember_digest, nil)
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

  def feed
    Lunch.where('account_id = ?', account_id)
  end
end
