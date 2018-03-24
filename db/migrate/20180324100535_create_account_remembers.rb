class CreateAccountRemembers < ActiveRecord::Migration[5.2]
  def up
    create_table :account_remembers, id: false do |t|
      t.references :account, null: false
      t.string :remember_digest, null: false

      t.timestamps
    end

    add_foreign_key :account_remembers,
                    :accounts,
                    primary_key: :account_id
  end

  def down
    drop_table :account_remembers
  end
end
