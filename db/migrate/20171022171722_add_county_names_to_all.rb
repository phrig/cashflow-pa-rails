class AddCountyNamesToAll < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :county_name, :string
    add_column :debts, :county_name, :string
    add_column :expenses, :county_name, :string
    add_column :filers, :county_name, :string
    add_column :receipts, :county_name, :string
  end
end
