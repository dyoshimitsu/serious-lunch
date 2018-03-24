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

    sql = <<~SQL
      INSERT INTO account_resets (
        account_id,
        reset_digest,
        created_at,
        updated_at
      )
        SELECT
          account_id,
          reset_digest,
          reset_sent_at,
          reset_sent_at
        FROM accounts
        WHERE reset_digest IS NOT NULL
    SQL
    ActiveRecord::Base.connection.execute(sql)

    remove_column :accounts, :reset_sent_at
    remove_column :accounts, :reset_digest
  end

  def down
    add_column :accounts, :reset_digest, :string, after: :activated_at
    add_column :accounts, :reset_sent_at, :datetime, after: :reset_digest

    sql = <<~SQL
      UPDATE
          accounts,
          account_resets
      SET
        accounts.reset_digest  = account_resets.reset_digest,
        accounts.reset_sent_at = account_resets.created_at
      WHERE
        accounts.account_id = account_resets.account_id
    SQL
    ActiveRecord::Base.connection.execute(sql)

    drop_table :account_resets
  end
end
