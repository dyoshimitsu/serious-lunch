# frozen_string_literal: true

class CreateAccountRemembers < ActiveRecord::Migration[5.2]
  def up
    create_table :account_remembers, id: false do |t|
      t.bigint :account_id, null: false
      t.string :remember_digest, null: false

      t.timestamps

      t.index :account_id, unique: true
    end

    add_foreign_key :account_remembers,
                    :accounts,
                    primary_key: :account_id

    ActiveRecord::Base.connection.execute(upload_sql)

    remove_column :accounts, :remember_digest
  end

  def down
    add_column :accounts, :remember_digest, :string,
               after: :password_digest

    ActiveRecord::Base.connection.execute(download_sql)

    drop_table :account_remembers
  end

  private

  def upload_sql
    <<~SQL
      INSERT INTO account_remembers (
        account_id,
        remember_digest,
        created_at,
        updated_at
      )
        SELECT
          account_id,
          remember_digest,
          updated_at,
          updated_at
        FROM accounts
        WHERE remember_digest IS NOT NULL
    SQL
  end

  def download_sql
    <<~SQL
      UPDATE
          accounts,
          account_remembers
      SET
        accounts.remember_digest = account_remembers.remember_digest
      WHERE
        accounts.account_id = account_remembers.account_id
    SQL
  end
end
