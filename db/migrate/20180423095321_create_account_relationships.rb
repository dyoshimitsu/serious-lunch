class CreateAccountRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :account_relationships do |t|
      t.bigint :follower_account_id
      t.bigint :followed_account_id

      t.timestamps
    end
  end
end
