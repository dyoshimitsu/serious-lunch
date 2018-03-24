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

    drop_table :account_activations
  end
end
