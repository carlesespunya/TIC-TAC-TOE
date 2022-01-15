class AddBoardToGames < ActiveRecord::Migration[6.1]
  def change
    add_column :games, :board, :text, array: true, default: ["", "", "", "", "", "", "", "", ""]
  end
end
