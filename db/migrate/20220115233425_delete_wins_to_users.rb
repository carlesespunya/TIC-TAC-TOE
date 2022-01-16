class DeleteWinsToUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :wins, :integer
    remove_column :users, :losses, :integer
    remove_column :users, :draws, :integer
  end
end
