# frozen_string_literal: true

class CreateVisitRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_restaurants, :primary_key => :visit_restaurant_id do |t|
      t.bigint :account_id, null: false
      t.datetime :visit_date, null: false
      t.string :comment

      t.timestamps
    end

    add_index :visit_restaurants, [:account_id, :visit_date]
    add_index :visit_restaurants, [:account_id, :created_at]
    add_foreign_key :visit_restaurants,
                    :accounts,
                    primary_key: :account_id
  end
end
