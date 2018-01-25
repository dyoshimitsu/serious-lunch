# frozen_string_literal: true

class AddRememberDigestToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :remember_digest, :string, after: :password_digest
  end
end
