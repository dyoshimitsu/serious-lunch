class RenameEmailColumnToEmailAddress < ActiveRecord::Migration[5.2]
  def change
    rename_column :accounts, :email, :email_address
  end
end
