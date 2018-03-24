class CreateAccountRemembers < ActiveRecord::Migration[5.2]
  def change
    create_table :account_remembers do |t|

      t.timestamps
    end
  end
end
