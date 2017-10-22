class AddDistrictsToAll < ActiveRecord::Migration[5.1]
  def change
    add_column :contributions, :district, :integer
    add_column :debts, :district, :integer
    add_column :expenses, :district, :integer
    add_column :receipts, :district, :integer
  end
end
