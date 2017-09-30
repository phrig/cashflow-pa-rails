class ChangeLatLongTypeOnExpenses < ActiveRecord::Migration[5.1]
  def change
    change_column :expenses, :expense_location_1_lat, :float, using: 'CAST(expense_location_1_lat as DOUBLE PRECISION)'
    change_column :expenses, :expense_location_1_long, :float, using: 'CAST(expense_location_1_long as DOUBLE PRECISION)'
  end
end
