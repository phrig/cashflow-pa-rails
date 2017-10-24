class CreateSenateDistricts < ActiveRecord::Migration[5.1]
  def change
    create_table :senate_districts do |t|
      t.string :s_first_name
      t.string :s_last_name
      t.string :home_county
      t.string :party
      t.integer :legislative_district
      t.json :feature
    end
  end
end
