class CreateAccountResets < ActiveRecord::Migration[5.2]
  def up
    create_table :account_resets, id: false do |t|
      t.references :account, null: false
      t.string :reset_digest, null: false

      t.timestamps
    end

    add_foreign_key :account_resets,
                    :accounts,
                    primary_key: :account_id
  end

  def down
    drop_table :account_resets
  end
end
