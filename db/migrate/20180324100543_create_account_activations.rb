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

    sql = <<~SQL
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
    ActiveRecord::Base.connection.execute(sql)

    sql = <<~SQL
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
    ActiveRecord::Base.connection.execute(sql)

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

    sql = <<~SQL
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
    ActiveRecord::Base.connection.execute(sql)

    sql = <<~SQL
      UPDATE
          accounts,
          account_activations
      SET
        accounts.activation_digest = account_activations.activation_digest
      WHERE
        accounts.account_id = account_activations.account_id AND
        account_activations.activated = FALSE
    SQL
    ActiveRecord::Base.connection.execute(sql)

    drop_table :account_activations
  end
end
