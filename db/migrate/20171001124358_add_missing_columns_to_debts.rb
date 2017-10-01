class AddMissingColumnsToDebts < ActiveRecord::Migration[5.1]
  def change
    rename_column :debts, :debt_reporting_location2, :debt_reporting_location_2
    add_column :debts, :debt_reporting_location_1_lat, :float
    add_column :debts, :debt_reporting_location_1_long, :float
    change_column :debts, :debt_reporting_location_1, :json, using: 'CAST(debt_reporting_location_1 as JSON)'
    add_column :debts, :debt_reporting_location_2_lat, :float
    add_column :debts, :debt_reporting_location_2_long, :float
    change_column :debts, :debt_reporting_location_2, :json, using: 'CAST(debt_reporting_location_2 as JSON)'
    add_column :debts, :debt_reporting_location_1_address, :string
    add_column :debts, :debt_reporting_location_2_address, :string
    add_column :debts, :debt_reporting_location_1_city, :string
    add_column :debts, :debt_reporting_location_2_city, :string
    add_column :debts, :debt_reporting_location_1_state, :string
    add_column :debts, :debt_reporting_location_2_state, :string
    add_column :debts, :debt_reporting_location_1_zipcode, :string
    add_column :debts, :debt_reporting_location_2_zipcode, :string
  end
end
