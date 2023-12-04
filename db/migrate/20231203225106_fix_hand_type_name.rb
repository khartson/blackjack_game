class FixHandTypeName < ActiveRecord::Migration[7.1]
  def change
    rename_column :hands, :type, :hand_type
  end
end
