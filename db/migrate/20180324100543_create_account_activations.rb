class CreateAccountActivations < ActiveRecord::Migration[5.2]
  def up
    create_table :account_activations, id: false do |t|
      t.references :account, null: false
      t.boolean :activated, null: false, default: false
      t.string :reset_digest, null: false

      t.timestamps
    end

    add_foreign_key :account_activations,
                    :accounts,
                    primary_key: :account_id
  end

  def down
    drop_table :account_activations
  end
end
