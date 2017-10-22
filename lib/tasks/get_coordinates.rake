require 'geocoder'

desc "Import data from OpenDataPA"

namespace :get_coordinates do

  task all: [:expenses, :receipts, :debts, :contributions, :filers]

  task expenses: :environment do
    desc "Geolocate expenses"

    Expense.all.map do |expense|
      if expense.expense_location_1_lat.blank? && expense.expense_location_2_lat.blank?
        # coordinates = Geocoder.coordinates(
        #   "#{expense.expense_address_1}, #{expense.expense_city}, #{expense.expense_state}" )
        # unless coordinates.blank?
        #   expense.expense_location_1_lat = coordinates[0]
        #   expense.expense_location_1_long = coordinates[1]
        #   expense.expense_location_2_lat = coordinates[0]
        #   expense.expense_location_2_long = coordinates[1]
        #   if expense.save
        #     puts "Saving #{expense.name}"
        #   end
        # else
        #   puts "#{expense.expense_address_1} not found."
        # end
        # sleep 3
      elsif expense.expense_location_1_lat.blank? && !expense.expense_location_2_lat.blank?
        expense.expense_location_1_lat = expense.expense_location_2_lat
        expense.expense_location_1_long = expense.expense_location_2_long
        expense.save
        puts "Saving from existing record (2 to 1)."
      end
    end
  end

  task receipts: :environment do
    desc "Geolocate receipts"

    Receipt.all.map do |receipt|
      if receipt.receipt_location_1_lat.blank? && receipt.receipt_location_2_lat.blank?
        # coordinates = Geocoder.coordinates(
        #   "#{receipt.receipt_address_1}, #{receipt.receipt_city}, #{receipt.receipt_state}" )
        # unless coordinates.blank?
        #   receipt.receipt_location_1_lat = coordinates[0]
        #   receipt.receipt_location_1_long = coordinates[1]
        #   receipt.receipt_location_2_lat = coordinates[0]
        #   receipt.receipt_location_2_long = coordinates[1]
        #   if receipt.save
        #     puts "Saving #{receipt.name}"
        #   end
        # else
        #   puts "#{receipt.receipt_address_1} not found."
        # end
        # sleep 3
      elsif receipt.receipt_location_1_lat.blank? && !receipt.receipt_location_2_lat.blank?
        receipt.receipt_location_1_lat = receipt.receipt_location_2_lat
        receipt.receipt_location_1_long = receipt.receipt_location_2_long
        receipt.save
        puts "Saving from existing record (2 to 1)."
      end
    end
  end

  task debts: :environment do
    desc "Geolocate debts"

    Debt.all.map do |debt|
      if debt.debt_reporting_location_1_lat.blank? && debt.debt_reporting_location_2_lat.blank?
        # coordinates = Geocoder.coordinates(
        #   "#{debt.debt_address_1}, #{debt.debt_city}, #{debt.debt_state}" )
        # unless coordinates.blank?
        #   debt.debt_reporting_location_1_lat = coordinates[0]
        #   debt.debt_reporting_location_1_long = coordinates[1]
        #   debt.debt_reporting_location_2_lat = coordinates[0]
        #   debt.debt_reporting_location_2_long = coordinates[1]
        #   if debt.save
        #     puts "Saving #{debt.debt_description}"
        #   end
        # else
        #   puts "#{debt.debt_address_1} not found."
        # end
        # sleep 3
      elsif debt.debt_reporting_location_1_lat.blank? && !debt.debt_reporting_location_2_lat.blank?
        debt.debt_reporting_location_1_lat = debt.debt_reporting_location_2_lat
        debt.debt_reporting_location_1_long = debt.debt_reporting_location_2_long
        debt.save
        puts "Saving from existing record (2 to 1)."
      end
    end
  end

  task contributions: :environment do
    desc "Geolocate contributions"

    Contribution.all.map do |contribution|
      if contribution.contributor_location_1_lat.blank? && contribution.contributor_location_2_lat.blank?
        # coordinates = Geocoder.coordinates(
        #   "#{contribution.contribution_address_1}, #{contribution.contribution_city}, #{contribution.contribution_state}" )
        # unless coordinates.blank?
        #   contribution.contributor_location_1_lat = coordinates[0]
        #   contribution.contributor_location_1_long = coordinates[1]
        #   contribution.contributor_location_2_lat = coordinates[0]
        #   contribution.contributor_location_2_long = coordinates[1]
        #   if contribution.save
        #     puts "Saving #{contribution.contributor}"
        #   end
        # else
        #   puts "#{contribution.contribution_address_1} not found."
        # end
        # sleep 3
      elsif contribution.contributor_location_1_lat.blank? && !contribution.contributor_location_2_lat.blank?
        contribution.contributor_location_1_lat = contribution.contributor_location_2_lat
        contribution.contributor_location_1_long = contribution.contributor_location_2_long
        contribution.save
        puts "Saving from existing record (2 to 1)."
      end
    end
  end

  task filers: :environment do
    desc "Geolocate filers"

    Filer.all.map do |filer|
      if filer.filer_location_1_lat.blank? && filer.filer_location_2_lat.blank?
        # coordinates = Geocoder.coordinates(
        #   "#{filer.filer_address_1}, #{filer.filer_city}, #{filer.filer_state}" )
        # unless coordinates.blank?
        #   filer.filer_location_1_lat = coordinates[0]
        #   filer.filer_location_1_long = coordinates[1]
        #   filer.filer_location_2_lat = coordinates[0]
        #   filer.filer_location_2_long = coordinates[1]
        #   if filer.save
        #     puts "Saving #{filer.filer_name}"
        #   end
        # else
        #   puts "#{filer.filer_address_1} not found."
        # end
        # sleep 3
      elsif filer.filer_location_1_lat.blank? && !filer.filer_location_2_lat.blank?
        filer.filer_location_1_lat = filer.filer_location_2_lat
        filer.filer_location_1_long = filer.filer_location_2_long
        filer.save
        puts "Saving from existing record (2 to 1)."
      end
    end
  end
end
