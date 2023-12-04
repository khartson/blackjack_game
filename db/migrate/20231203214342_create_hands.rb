class CreateHands < ActiveRecord::Migration[7.1]
  def change
    create_table :hands do |t|
      t.references :deck, null: false, foreign_key: true
      t.string :type
      t.string :pile_url
      t.string :pile_id

      t.timestamps
    end
  end
end
