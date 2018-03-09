# frozen_string_literal: true

class CreateLunches < ActiveRecord::Migration[5.2]
  def change
    create_table :lunches, :primary_key => :lunch_id do |t|
      t.bigint :account_id, null: false
      t.date :lunch_date, null: false
      t.string :comment

      t.timestamps
    end

    add_index :lunches, [:account_id, :lunch_date]
    add_index :lunches, [:account_id, :created_at]
    add_foreign_key :lunches,
                    :accounts,
                    primary_key: :account_id
  end
end
