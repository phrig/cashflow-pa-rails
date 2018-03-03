class AddIndicesOnTransactions < ActiveRecord::Migration[5.1]
  def change
    add_index :expenses, [:expense_location_1_lat, :expense_location_1_long], name: 'expense_lat_long'
    add_index :debts, [:debt_reporting_location_1_lat, :debt_reporting_location_1_long], name: 'debt_lat_long'
    add_index :receipts, [:receipt_location_1_lat, :receipt_location_1_long], name: 'receipt_lat_long'
    add_index :contributions, [:contributor_location_1_lat, :contributor_location_1_long], name: 'contribution_lat_long'
    add_index :filers, [:filer_location_1_lat, :filer_location_1_long], name: 'filer_lat_long'
  end
end
