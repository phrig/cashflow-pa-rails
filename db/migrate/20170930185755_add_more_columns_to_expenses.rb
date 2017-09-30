class AddMoreColumnsToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :expense_location_1_city, :string
    add_column :expenses, :expense_location_1_state, :string
    add_column :expenses, :expense_location_1_zip, :string
    add_column :expenses, :expense_location_2_city, :string
    add_column :expenses, :expense_location_2_state, :string
    add_column :expenses, :expense_location_2_zip, :string
  end
end
