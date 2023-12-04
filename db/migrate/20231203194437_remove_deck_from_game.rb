class RemoveDeckFromGame < ActiveRecord::Migration[7.1]
  def change
    remove_column :games, :deck
  end
end
