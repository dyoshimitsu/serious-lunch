class CreateAccountResets < ActiveRecord::Migration[5.2]
  def change
    create_table :account_resets do |t|

      t.timestamps
    end
  end
end
