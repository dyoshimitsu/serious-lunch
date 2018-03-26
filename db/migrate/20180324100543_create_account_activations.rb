# frozen_string_literal: true

class CreateAccountActivations < ActiveRecord::Migration[5.2]
  def up
    create_table :account_activations, id: false do |t|
      t.bigint :account_id, null: false
      t.string :activation_digest, null: false
      t.boolean :activated, null: false, default: false

      t.timestamps

      t.index :account_id, unique: true
      t.index :activated
    end

    add_foreign_key :account_activations,
                    :accounts,
                    primary_key: :account_id

    ActiveRecord::Base.connection.execute(upload_sql_when_activated_is_true)
    ActiveRecord::Base.connection.execute(upload_sql_when_activated_is_false)

    remove_column :accounts, :activated_at
    remove_column :accounts, :activated
    remove_column :accounts, :activation_digest
  end

  def down
    add_column :accounts, :activation_digest, :string,
               after: :remember_digest
    add_column :accounts, :activated, :boolean,
               default: false,
               null: false,
               after: :activation_digest
    add_column :accounts, :activated_at, :datetime,
               after: :activated

    add_index :accounts, :activated

    ActiveRecord::Base.connection.execute(download_sql_when_activated_is_true)
    ActiveRecord::Base.connection.execute(download_sql_when_activated_is_false)

    drop_table :account_activations
  end

  private

  def upload_sql_when_activated_is_true
    <<~SQL
      INSERT INTO account_activations (
        account_id,
        activation_digest,
        activated,
        created_at,
        updated_at
      )
        SELECT
          account_id,
          activation_digest,
          activated,
          created_at,
          activated_at
        FROM accounts
        WHERE activated = TRUE
    SQL
  end

  def upload_sql_when_activated_is_false
    <<~SQL
      INSERT INTO account_activations (
        account_id,
        activation_digest,
        activated,
        created_at,
        updated_at
      )
        SELECT
          account_id,
          activation_digest,
          activated,
          created_at,
          created_at
        FROM accounts
        WHERE activated = FALSE
    SQL
  end

  def download_sql_when_activated_is_true
    <<~SQL
      UPDATE
          accounts,
          account_activations
      SET
        accounts.activation_digest = account_activations.activation_digest,
        accounts.activated         = account_activations.activated,
        accounts.activated_at      = account_activations.updated_at
      WHERE
        accounts.account_id = account_activations.account_id AND
        account_activations.activated = TRUE
    SQL
  end

  def download_sql_when_activated_is_false
    <<~SQL
      UPDATE
          accounts,
          account_activations
      SET
        accounts.activation_digest = account_activations.activation_digest
      WHERE
        accounts.account_id = account_activations.account_id AND
        account_activations.activated = FALSE
    SQL
  end
end
