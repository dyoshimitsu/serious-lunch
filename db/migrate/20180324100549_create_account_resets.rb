# frozen_string_literal: true

class CreateAccountResets < ActiveRecord::Migration[5.2]
  def up
    create_table :account_resets, id: false do |t|
      t.bigint :account_id, null: false
      t.string :reset_digest, null: false

      t.timestamps

      t.index :account_id, unique: true
    end

    add_foreign_key :account_resets,
                    :accounts,
                    primary_key: :account_id

    remove_column :accounts, :reset_sent_at
    remove_column :accounts, :reset_digest
  end

  def down
    add_column :accounts, :reset_digest, :string, after: :activated_at
    add_column :accounts, :reset_sent_at, :datetime, after: :reset_digest

    drop_table :account_resets
  end
end
