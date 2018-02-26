class CreateVisitRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :visit_restaurants do |t|
      t.bigint :account_id, null: false
      t.string :comment

      t.timestamps
    end

    add_index :visit_restaurants, [:account_id, :created_at], unique: true
    add_foreign_key :visit_restaurants,
                    :accounts,
                    primary_key: :account_id
  end
end
