require 'httparty'

desc "Import data from OpenDataPA"

namespace :import do

  task all: [:expenses]

  task expenses: :environment do
    desc "Import all expenses data from OpenDataPA"

    response = HTTParty.get(  'https://data.pa.gov/resource/hiuk-jafv.json',
                              query: {'$limit' => 50000 },
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
        expense.expense_location_1_lat = expense_obj["expense_location_1"]["coordinates"].last.to_f
        expense.expense_location_1_long = expense_obj["expense_location_1"]["coordinates"].first.to_f
      end
      expense.expense_location_1 = expense_obj["expense_location_1"]
      expense.expense_location_1_address = expense_obj["expense_location_1_address"]
      expense.expense_location_1_city = expense_obj["expense_location_1_city"]
      expense.expense_location_1_state = expense_obj["expense_location_1_state"]
      expense.expense_location_1_zip = expense_obj["expense_location_1_zip"]
      if !expense_obj["expense_location_2"].nil?
        expense.expense_location_2_lat = expense_obj["expense_location_2"]["coordinates"].last.to_f
        expense.expense_location_2_long = expense_obj["expense_location_2"]["coordinates"].first.to_f
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

  task receipts: :environment do
    desc "Import all expenses data from OpenDataPA"
    response = HTTParty.get(  'https://data.pa.gov/resource/dq5j-n7t2.json',
                              query: {'$limit' => 5000 },
                              headers: {'X-App-Token' => 'n4EA22fkjanBVoRtLsvv6Fp0V' }
                            )

    response.each do |receipt_obj|
      receipt = Receipt.new
      receipt_obj[""]

      # More universal values
      receipt.election_cycle = receipt_obj["election_cycle"].to_i
      receipt.election_year = receipt_obj["election_year"].to_i
      receipt.filer_id = receipt_obj["filer_identification_number"]
      receipt.name = receipt_obj["name"]
      receipt.receipt_amount = receipt_obj["receipt_amount"].to_f
      if !receipt_obj["receipt_date"].nil? # odd that the receipt date wouldn't exist
        receipt.receipt_date = Date.parse(receipt_obj["receipt_date"])
      end
      receipt.receipt_description = receipt_obj["receipt_description"]

      # Less universal values
      # Since these are fairly lat JSON, checking every field is saver
      # than what appears in the expenses import task.

      if !receipt_obj["receipt_address_1"].nil?
        receipt.receipt_address_1 = receipt_obj["receipt_address_1"]
      end
      if !receipt_obj["receipt_address_2"].nil?
        receipt.receipt_address_2 = receipt_obj["receipt_address_2"]
      end
      if !receipt_obj["receipt_city"].nil?
        receipt.receipt_city = receipt_obj["receipt_city"]
      end
      if !receipt_obj["receipt_city"].nil?
        receipt.receipt_city = receipt_obj["receipt_city"]
      end
      if !receipt_obj["receipt_location_1_address"].nil?
        receipt.receipt_location_1_address = receipt_obj["receipt_location_1_address"]
      end
      if !receipt_obj["receipt_location_1_city"].nil?
        receipt.receipt_location_1_city = receipt_obj["receipt_location_1_city"]
      end
      if !receipt_obj["receipt_location_1_state"].nil?
        receipt.receipt_location_1_state = receipt_obj["receipt_location_1_state"]
      end
      if !receipt_obj["receipt_location_1_zip"].nil?
        receipt.receipt_location_1_zip = receipt_obj["receipt_location_1_zip"]
      end
      if !receipt_obj["receipt_location_2_address"].nil?
        receipt.receipt_location_2_address = receipt_obj["receipt_location_2_address"]
      end
      if !receipt_obj["receipt_location_2_city"].nil?
        receipt.receipt_location_2_city = receipt_obj["receipt_location_2_city"]
      end
      if !receipt_obj["receipt_location_2_state"].nil?
        receipt.receipt_location_2_state = receipt_obj["receipt_location_2_state"]
      end
      if !receipt_obj["receipt_location_2_zip"].nil?
        receipt.receipt_location_2_zip = receipt_obj["receipt_location_2_zip"]
      end

      if receipt.save
        puts "#{receipt.name} successfully saved."
      else
        puts "Something went wrong saving #{receipt_obj['name']}"
      end

    end
  end

  task contributions: :environment do
    desc "Import all expenses data from OpenDataPA"
    response = HTTParty.get(  'https://data.pa.gov/resource/3nz5-zuve.json',
                              query: {'$limit' => 5000 },
                              headers: {'X-App-Token' => 'n4EA22fkjanBVoRtLsvv6Fp0V' }
                            )

    response.each do |contribution_obj|
      begin
      contribution = Contribution.new
      contribution_obj[""]

      # More universal values
      contribution.election_cycle = contribution_obj["election_cycle"].to_i
      contribution.election_year = contribution_obj["election_year"].to_i
      contribution.filer_id = contribution_obj["filer_identification_number"]
      contribution.name = contribution_obj["name"]
      contribution.contribution_amount = contribution_obj["contribution_amount"].to_f
      if !contribution_obj["contribution_date"].nil? # odd that the contribution date wouldn't exist
        contribution.contribution_date = Date.parse(contribution_obj["contribution_date"])
      end
      contribution.contribution_description = contribution_obj["contribution_description"]

      # Less universal values
      # Since these are fairly lat JSON, checking every field is saver
      # than what appears in the expenses import task.

      if !contribution_obj["contribution_address_1"].nil?
        contribution.contribution_address_1 = contribution_obj["contribution_address_1"]
      end
      if !contribution_obj["contribution_address_2"].nil?
        contribution.contribution_address_2 = contribution_obj["contribution_address_2"]
      end
      if !contribution_obj["contribution_city"].nil?
        contribution.contribution_city = contribution_obj["contribution_city"]
      end
      if !contribution_obj["contribution_city"].nil?
        contribution.contribution_city = contribution_obj["contribution_city"]
      end
      if !contribution_obj["contribution_location_1_address"].nil?
        contribution.contribution_location_1_address = contribution_obj["contribution_location_1_address"]
      end
      if !contribution_obj["contribution_location_1_city"].nil?
        contribution.contribution_location_1_city = contribution_obj["contribution_location_1_city"]
      end
      if !contribution_obj["contribution_location_1_state"].nil?
        contribution.contribution_location_1_state = contribution_obj["contribution_location_1_state"]
      end
      if !contribution_obj["contribution_location_1_zip"].nil?
        contribution.contribution_location_1_zip = contribution_obj["contribution_location_1_zip"]
      end
      if !contribution_obj["contribution_location_2_address"].nil?
        contribution.contribution_location_2_address = contribution_obj["contribution_location_2_address"]
      end
      if !contribution_obj["contribution_location_2_city"].nil?
        contribution.contribution_location_2_city = contribution_obj["contribution_location_2_city"]
      end
      if !contribution_obj["contribution_location_2_state"].nil?
        contribution.contribution_location_2_state = contribution_obj["contribution_location_2_state"]
      end
      if !contribution_obj["contribution_location_2_zip"].nil?
        contribution.contribution_location_2_zip = contribution_obj["contribution_location_2_zip"]
      end

    rescue TypeError => error
      binding.pry
    end

      if contribution.save
        puts "#{contribution.name} successfully saved."
      else
        puts "Something went wrong saving #{contribution_obj['name']}"
      end
    end
  end

end