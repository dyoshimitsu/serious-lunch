class CreateAccountActivations < ActiveRecord::Migration[5.2]
  def change
    create_table :account_activations do |t|

      t.timestamps
    end
  end
end
