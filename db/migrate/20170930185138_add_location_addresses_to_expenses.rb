class AddLocationAddressesToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :expense_location_1_address, :string
    add_column :expenses, :expense_location_2_address, :string
  end
end
