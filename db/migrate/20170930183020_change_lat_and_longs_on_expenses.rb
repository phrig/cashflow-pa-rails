class ChangeLatAndLongsOnExpenses < ActiveRecord::Migration[5.1]
  def change
    rename_column :expenses, :lat, :expense_location_1_lat
    rename_column :expenses, :long, :expense_location_1_long
    add_column :expenses, :expense_location_2_lat, :float
    add_column :expenses, :expense_location_2_long, :float
  end
end
