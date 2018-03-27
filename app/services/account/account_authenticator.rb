# frozen_string_literal: true

class Account::AccountAuthenticator
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

    def authenticated?(digest, token)
      BCrypt::Password.new(digest).is_password?(token)
    end
  end
end
