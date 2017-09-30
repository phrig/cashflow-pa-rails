class CreateDebts < ActiveRecord::Migration[5.1]
  def change
    create_table :debts do |t|
      t.string :filer_id
      t.integer :election_year
      t.integer :election_cycle
      t.string :debt_reporter_name
      t.string :debt_reporting_address_1
      t.string :debt_reporting_address_2
      t.string :debt_reporting_city
      t.string :debt_reporting_state
      t.string :debt_reporting_zipcode
      t.date :debt_accrual_date
      t.float :debt_amount
      t.string :debt_description
      t.string :debt_reporting_location_1
      t.string :debt_reporting_location2
      t.timestamps
    end
  end
end
