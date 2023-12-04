class RemovePileIdFromHand < ActiveRecord::Migration[7.1]
  def change
    remove_column :hands, :pile_id
  end
end
