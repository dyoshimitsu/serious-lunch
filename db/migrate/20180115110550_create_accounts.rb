# frozen_string_literal: true

class CreateAccounts < ActiveRecord::Migration[5.2]
  def change
    create_table :accounts, :primary_key => :account_id do |t|
      t.string :account_name, null: false, limit: 50
      t.string :email, null: false
      t.string :password_digest, null: false

      t.timestamps
      t.index :account_name, unique: true
      t.index :email, unique: true
    end
  end
end
