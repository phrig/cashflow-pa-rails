class ChangeExpenseLocationOne < ActiveRecord::Migration[5.1]
  def change
    change_column :expenses, :expense_location_1, :json, using: 'CAST(expense_location_1 as JSON)'
    change_column :expenses, :expense_location_2, :json, using: 'CAST(expense_location_2 as JSON)'
  end
end
