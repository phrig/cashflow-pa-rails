class CreateContributions < ActiveRecord::Migration[5.1]
  def change
    create_table :contributions do |t|
      t.integer :filer_id
      t.integer :election_year
      t.integer :election_cycle
      t.string :section
      t.string :contributor
      t.string :contributor_address_1
      t.string :contributor_address_2
      t.string :contributor_city
      t.string :contributor_state
      t.string :contributor_zipcode
      t.string :occupation
      t.string :employer_name
      t.string :employer_address_1
      t.string :employer_address_2
      t.string :employer_state
      t.string :employer_city
      t.string :employer_zipcode
      t.date :contribution_date
      t.float :contribution_amount
      t.string :contribution_description
      t.string :contributor_location_1
      t.string :contributor_location_2
      t.string :employer_location_1
      t.string :employer_location_2
      t.timestamps
    end
  end
end
