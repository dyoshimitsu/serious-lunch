# frozen_string_literal: true

class CreateAccountRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :account_relationships, id: false do |t|
      t.bigint :follower_account_id, null: false
      t.bigint :followed_account_id, null: false

      t.timestamps
    end

    add_index :account_relationships,
              [:follower_account_id, :followed_account_id],
              name: 'index_account_relationships_on_follower_and_followed',
              unique: true
    add_index :account_relationships,
              [:followed_account_id, :follower_account_id],
              name: 'index_account_relationships_on_followed_and_follower',
              unique: true
  end
end
