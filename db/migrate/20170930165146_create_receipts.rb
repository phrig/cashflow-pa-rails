class CreateReceipts < ActiveRecord::Migration[5.1]
  def change
    create_table :receipts do |t|
      t.integer :filer_id
      t.integer :election_year
      t.integer :election_cycle
      t.string :name
      t.string :receipt_address_1
      t.string :receipt_address_2
      t.string :receipt_city
      t.string :receipt_state
      t.string :receipt_zipcode
      t.string :receipt_description
      t.date :receipt_date
      t.float :receipt_amount
      t.string :receipt_location_1
      t.string :receipt_location_2
      t.timestamps
    end
  end
end
