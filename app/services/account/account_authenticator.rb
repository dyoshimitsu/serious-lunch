# frozen_string_literal: true

class Account::AccountAuthenticator
  include Virtus.model

  attribute :account, Account, reader: :private

  class << self
    def digest(string)
      cost =
        if ActiveModel::SecurePassword.min_cost
          BCrypt::Engine::MIN_COST
        else
          BCrypt::Engine.cost
        end
      BCrypt::Password.create(string, cost: cost)
    end

    def new_token
      SecureRandom.urlsafe_base64
    end
  end

  def activation_authenticated?(activation_token)
    authenticated?(account&.account_activation&.activation_digest, activation_token)
  end

  def remember_authenticated?(remember_token)
    authenticated?(account&.account_cookie&.remember_digest, remember_token)
  end

  def reset_authenticated?(reset_token)
    authenticated?(account&.account_reset&.reset_digest, reset_token)
  end

  private

  def authenticated?(digest, token)
    return false if digest.nil?
    BCrypt::Password.new(digest).is_password?(token)
  end
end
