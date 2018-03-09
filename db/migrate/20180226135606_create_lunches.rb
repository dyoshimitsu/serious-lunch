# frozen_string_literal: true

class CreateLunches < ActiveRecord::Migration[5.2]
  def change
    create_table :lunches, :primary_key => :visit_restaurant_id do |t|
      t.bigint :account_id, null: false
      t.datetime :lunch_day, null: false
      t.string :comment

      t.timestamps
    end

    add_index :lunches, [:account_id, :visit_date]
    add_index :lunches, [:account_id, :created_at]
    add_foreign_key :lunches,
                    :accounts,
                    primary_key: :account_id
  end
end
