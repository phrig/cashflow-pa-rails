class CreateHouseDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :house_districts do |t|
      t.string :h_first_name
      t.string :h_last_name
      t.string :home_county
      t.string :party
      t.integer :legislative_district
      t.json :feature
    end
  end
end
