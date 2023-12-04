class CreateDecks < ActiveRecord::Migration[7.1]
  def change
    create_table :decks do |t|
      t.string :deck_url
      t.string :deck_id
      t.integer :remaining_cards

      t.timestamps
    end
  end
end
