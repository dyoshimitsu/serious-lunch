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

    remove_column :accounts, :remember_digest
  end

  def down
    add_column :accounts, :remember_digest, :string,
               after: :password_digest

    drop_table :account_remembers
  end
end
