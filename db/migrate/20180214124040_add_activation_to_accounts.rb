# frozen_string_literal: true

class AddActivationToAccounts < ActiveRecord::Migration[5.2]
  def change
    add_column :accounts, :activation_digest, :string,
               after: :remember_digest
    add_column :accounts, :activated, :boolean,
               default: false,
               null: false,
               after: :activation_digest
    add_column :accounts, :activated_at, :datetime,
               after: :activated

    add_index :accounts, :activated
  end
end
