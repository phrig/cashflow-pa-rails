class CreateFilers < ActiveRecord::Migration[5.1]
  def change
    create_table :filers do |t|
      t.integer :filer_id
      t.integer :election_year
      t.integer :election_cycle
      t.string :amended_report_indicator
      t.string :termination_indicator
      t.string :filer_type
      t.string :filer_name
      t.string :office
      t.string :district
      t.string :party
      t.string :filer_address_1
      t.string :filer_address_2
      t.string :filer_city
      t.string :filer_state
      t.string :filer_zipcode
      t.string :county
      t.string :phone_number
      t.float :beginning_balance
      t.float :monetary
      t.float :in_kind
      t.string :filer_location_1
      t.string :filer_location_2
      t.timestamps
    end
  end
end
