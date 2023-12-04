class CreateCards < ActiveRecord::Migration[7.1]
  def change
    create_table :cards do |t|
      t.string :code
      t.string :image_url
      t.integer :value
      t.string :suit
      t.references :hand, null: false, foreign_key: true

      t.timestamps
    end
  end
end
