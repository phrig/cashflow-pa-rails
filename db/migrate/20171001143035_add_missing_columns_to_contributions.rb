class AddMissingColumnsToContributions < ActiveRecord::Migration[5.1]
  def change
    change_column :contributions, :contributor_location_1, :json, using: 'CAST(contributor_location_1 as JSON)'
    change_column :contributions, :contributor_location_2, :json, using: 'CAST(contributor_location_2 as JSON)'
    add_column :contributions, :contributor_location_1_lat, :float
    add_column :contributions, :contributor_location_1_long, :float
    add_column :contributions, :contributor_location_2_lat, :float
    add_column :contributions, :contributor_location_2_long, :float
    add_column :contributions, :contributor_location_1_address, :string
    add_column :contributions, :contributor_location_2_address, :string
    add_column :contributions, :contributor_location_1_city, :string
    add_column :contributions, :contributor_location_2_city, :string
    add_column :contributions, :contributor_location_1_state, :string
    add_column :contributions, :contributor_location_2_state, :string
    add_column :contributions, :contributor_location_1_zip, :string
    add_column :contributions, :contributor_location_2_zip, :string
    change_column :contributions, :employer_location_1, :json, using: 'CAST(employer_location_1 as JSON)'
    change_column :contributions, :employer_location_2, :json, using: 'CAST(employer_location_2 as JSON)'
    add_column :contributions, :employer_location_1_lat, :float
    add_column :contributions, :employer_location_1_long, :float
    add_column :contributions, :employer_location_2_lat, :float
    add_column :contributions, :employer_location_2_long, :float
    add_column :contributions, :employer_location_1_address, :string
    add_column :contributions, :employer_location_2_address, :string
    add_column :contributions, :employer_location_1_city, :string
    add_column :contributions, :employer_location_2_city, :string
    add_column :contributions, :employer_location_1_state, :string
    add_column :contributions, :employer_location_2_state, :string
    add_column :contributions, :employer_location_1_zip, :string
    add_column :contributions, :employer_location_2_zip, :string
  end
end
