class AddLatLongToExpenses < ActiveRecord::Migration[5.1]
  def change
    add_column :expenses, :lat, :string
    add_column :expenses, :long, :string
  end
end
