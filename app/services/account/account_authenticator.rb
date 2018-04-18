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
    digest = account&.account_activation&.activation_digest
    if digest
      authenticated?(digest, activation_token)
    else
      false
    end
  end

  def remember_authenticated?(remember_token)
    digest = account&.account_cookie&.remember_digest
    if digest
      authenticated?(digest, remember_token)
    else
      false
    end
  end

  def reset_authenticated?(reset_token)
    digest = account&.account_reset&.reset_digest
    if digest
      authenticated?(digest, reset_token)
    else
      false
    end
  end

  private

  def authenticated?(digest, token)
    BCrypt::Password.new(digest).is_password?(token)
  end
end
