# frozen_string_literal: true

class Account < ApplicationRecord
  validates :account_name, format: { with: /\A[0-9a-zA-Z_]+\z/ }
end
