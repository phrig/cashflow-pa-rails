class AddLatLongToRecepts < ActiveRecord::Migration[5.1]
  def change
    add_column :receipts, :receipt_location_1_lat, :float
    add_column :receipts, :receipt_location_1_long, :float
    add_column :receipts, :receipt_location_2_lat, :float
    add_column :receipts, :receipt_location_2_long, :float
    remove_column :expenses, :receipt_location_1_lat, :float
    remove_column :expenses, :receipt_location_1_long, :float
    remove_column :expenses, :receipt_location_2_lat, :float
    remove_column :expenses, :receipt_location_2_long, :float
  end
end
