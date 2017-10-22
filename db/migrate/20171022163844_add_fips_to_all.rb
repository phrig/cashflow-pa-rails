class AddFipsToAll < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :state_fips, :integer
    add_column :contributions, :county_fips, :integer
    add_column :debts, :state_fips, :integer
    add_column :debts, :county_fips, :integer
    add_column :expenses, :state_fips, :integer
    add_column :expenses, :county_fips, :integer
    add_column :filers, :state_fips, :integer
    add_column :filers, :county_fips, :integer
    add_column :receipts, :state_fips, :integer
    add_column :receipts, :county_fips, :integer
  end
end
