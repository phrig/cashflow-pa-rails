class CreateCounties < ActiveRecord::Migration[5.1]
  def change
    create_table :counties do |t|
      t.string :county_name
      t.integer :county_fips
      t.json :feature
    end
  end
end
