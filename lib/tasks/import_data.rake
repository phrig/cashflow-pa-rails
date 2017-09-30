require 'httparty'

desc "Import data from OpenDataPA"

namespace :import do

  task all: [:expenses]

  task expenses: :environment do
    desc "Import all expenses data from OpenDataPA"

    response = HTTParty.get(  'https://data.pa.gov/resource/hiuk-jafv.json',
                              query: {'$limit' => 35000 },
                              headers: {'X-App-Token' => 'n4EA22fkjanBVoRtLsvv6Fp0V' }
                            )

    response.each do |expense_obj|
      expense = Expense.new
      expense.election_cycle = expense_obj["election_cycle"].to_i
      expense.election_year = expense_obj["election_year"].to_i
      expense.expense_address_1 = expense_obj["expense_address_1"]
      expense.expense_amount = expense_obj["expense_amount"].to_f
      expense.expense_city = expense_obj["expense_city"]
      if !expense_obj["expense_date"].nil?
        expense.expense_date = Date.parse(expense_obj["expense_date"])
      end
      expense.expense_description = expense_obj["expense_description"]
      if !expense_obj["expense_location_1"].nil?
        expense.expense_location_1_lat = expense_obj["expense_location_1"]["coordinates"].last
        expense.expense_location_1_long = expense_obj["expense_location_1"]["coordinates"].first
      end
      expense.expense_location_1 = expense_obj["expense_location_1"]
      expense.expense_location_1_address = expense_obj["expense_location_1_address"]
      expense.expense_location_1_city = expense_obj["expense_location_1_city"]
      expense.expense_location_1_state = expense_obj["expense_location_1_state"]
      expense.expense_location_1_zip = expense_obj["expense_location_1_zip"]
      if !expense_obj["expense_location_2"].nil?
        expense.expense_location_2_lat = expense_obj["expense_location_2"]["coordinates"].last
        expense.expense_location_2_long = expense_obj["expense_location_2"]["coordinates"].first
      end
      expense.expense_location_2 = expense_obj["expense_location_2"]
      if !expense_obj["expense_location_2_address"].nil?
        expense.expense_location_2_address = expense_obj["expense_location_2_address"]
        expense.expense_location_2_city = expense_obj["expense_location_2_city"]
        expense.expense_location_2_state = expense_obj["expense_location_2_state"]
        expense.expense_location_2_zip = expense_obj["expense_location_2_zip"]
      end
      expense.expense_state = expense_obj["expense_state"]
      expense.expense_zipcode = expense_obj["expense_zip_code"]
      expense.filer_id = expense_obj["filer_identification_number"].to_i
      expense.name = expense_obj["name"]

      if expense.save
        puts "#{expense.name} successfully saved."
      else
        puts "Something went wrong saving #{expense_obj['name']}"
      end
    end
  end

  task expenses: :environment do
    desc "Import all expenses data from OpenDataPA"
    response = HTTParty.get(  'https://data.pa.gov/resource/hiuk-jafv.json',
                              query: {'$limit' => 35000 },
                              headers: {'X-App-Token' => 'n4EA22fkjanBVoRtLsvv6Fp0V' }
                            )

    response.each do |expense_obj|
    end
  end

end