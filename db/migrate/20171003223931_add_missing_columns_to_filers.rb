class AddMissingColumnsToFilers < ActiveRecord::Migration[5.1]
  def change
    add_column :filers, :filer_location_1_address, :string
    add_column :filers, :filer_location_2_address, :string
    add_column :filers, :filer_location_1_city, :string
    add_column :filers, :filer_location_2_city, :string
    add_column :filers, :filer_location_1_state, :string
    add_column :filers, :filer_location_2_state, :string
    add_column :filers, :filer_location_1_zip, :string
    add_column :filers, :filer_location_2_zip, :string
    change_column :filers, :filer_type, :integer, using: 'CAST(filer_type as INTEGER)'
    change_column :filers, :county, :integer, using: 'CAST(county as INTEGER)'
    add_column :filers, :filer_location_1_lat, :float
    add_column :filers, :filer_location_1_long, :float
    change_column :filers, :filer_location_1, :json, using: 'CAST(filer_location_1 as JSON)'
    add_column :filers, :filer_location_2_lat, :float
    add_column :filers, :filer_location_2_long, :float
    change_column :filers, :filer_location_2, :json, using: 'CAST(filer_location_2 as JSON)'
    change_column :filers, :district, :integer, using: 'CAST(district as INTEGER)'
  end
end
