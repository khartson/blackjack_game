class AddDeckToGame < ActiveRecord::Migration[7.1]
  def change
    add_column :games, :deck, :string
  end
end
