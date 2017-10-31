require 'httparty'

desc "Import District Number data from Sunlight Foundation"

namespace :import_districts do

  task all: [:expenses, :receipts, :debts, :contributions, :filers]

  task expenses: :environment do
    desc "Import all District Number data for expenses"

    expenses = Expense.all

    expenses.map do |expense|
      unless expense.expense_location_1_lat.blank?
        response = HTTParty.get(  'https://congress.api.sunlightfoundation.com/districts/locate',
                              query: {  latitude: expense.expense_location_1_lat,
                                        longitude: expense.expense_location_1_long }
                            )
        unless response.blank?
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['FIPS'] = expense.county_fips
          end
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['name'] = expense.county_name
          end
          unless response.parsed_response['State'].blank?
            response.parsed_response['State']['FIPS'] = expense.state_fips
          end
        end
      end
      if expense.save
        puts "Saving #{expense.name}"
      end
    end
  end

  task receipts: :environment do
    desc "Import all FIPS data for receipts"

    receipts = Receipt.all

    receipts.map do |receipt|
      unless receipt.receipt_location_1_lat.blank?
        response = HTTParty.get(  'http://data.fcc.gov/api/block/find',
                              query: {  format: 'json',
                                        latitude: receipt.receipt_location_1_lat,
                                        longitude: receipt.receipt_location_1_long }
                            )
        unless response.blank?
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['FIPS'] = receipt.county_fips
          end
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['name'] = receipt.county_name
          end
          unless response.parsed_response['State'].blank?
            response.parsed_response['State']['FIPS'] = receipt.state_fips
          end
        end
      end
      if receipt.save
        puts "Saving #{receipt.name}"
      end
    end
  end

  task debts: :environment do
    desc "Import all FIPS data for debts"

    debts = Debt.all

    debts.map do |debt|
      unless debt.debt_reporting_location_1_lat.blank?
        response = HTTParty.get(  'http://data.fcc.gov/api/block/find',
                              query: {  format: 'json',
                                        latitude: debt.debt_reporting_location_1_lat,
                                        longitude: debt.debt_reporting_location_1_long }
                            )
        unless response.blank?
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['FIPS'] = debt.county_fips
          end
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['name'] = debt.county_name
          end
          unless response.parsed_response['State'].blank?
            response.parsed_response['State']['FIPS'] = debt.state_fips
          end
        end
      end
      if debt.save
        puts "Saving #{debt.debt_description}"
      end
    end
  end

  task contributions: :environment do
    desc "Import all FIPS data for contributions"

    contributions = Contribution.all

    contributions.map do |contribution|
      unless contribution.contributor_location_1_lat.blank?
        response = HTTParty.get(  'http://data.fcc.gov/api/block/find',
                              query: {  format: 'json',
                                        latitude: contribution.contributor_location_1_lat,
                                        longitude: contribution.contributor_location_1_long }
                            )
        unless response.blank?
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['FIPS'] = contribution.county_fips
          end
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['name'] = contribution.county_name
          end
          unless response.parsed_response['State'].blank?
            response.parsed_response['State']['FIPS'] = contribution.state_fips
          end
        end
      end
      if contribution.save
        puts "Saving #{contribution.contributor}"
      end
    end
  end

  task filers: :environment do
    desc "Import all FIPS data for filers"

    filers = Filer.all

    filers.map do |filer|
      unless filer.filer_location_1_lat.blank?
        response = HTTParty.get(  'http://data.fcc.gov/api/block/find',
                              query: {  format: 'json',
                                        latitude: filer.filer_location_1_lat,
                                        longitude: filer.filer_location_1_long }
                            )
        unless response.blank?
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['FIPS'] = filer.county_fips
          end
          unless response.parsed_response['County'].blank?
            response.parsed_response['County']['name'] = filer.county_name
          end
          unless response.parsed_response['State'].blank?
            response.parsed_response['State']['FIPS'] = filer.state_fips
          end
        end
      end
      if filer.save
        puts "Saving #{filer.filer_name}"
      end
    end
  end

end
