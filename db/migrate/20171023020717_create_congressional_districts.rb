class CreateCongressionalDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :congressional_districts do |t|
      t.string :c_first_name
      t.string :c_last_name
      t.string :home_county
      t.string :party
      t.integer :legislative_district
      t.json :feature
    end
  end
end
