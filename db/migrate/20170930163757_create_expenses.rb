class CreateExpenses < ActiveRecord::Migration[5.1]
  def change
    create_table :expenses do |t|
      t.integer :filer_id
      t.integer :election_year
      t.integer :election_cycle
      t.string  :name
      t.string :expense_address_1
      t.string :expense_address_2
      t.string :expense_city
      t.string :expense_state
      t.string  :expense_zipcode
      t.date :expense_date
      t.float :expense_amount
      t.string :expense_description
      t.string :expense_location_1
      t.string :expense_location_2
      t.timestamps
    end
  end
end
