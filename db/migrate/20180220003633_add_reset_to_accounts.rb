# frozen_string_literal: true

class AddResetToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :reset_digest, :string, after: :activated_at
    add_column :accounts, :reset_sent_at, :datetime, after: :reset_digest
  end
end
