require 'csv'

task add_filer_code: :environment do

  issues = []

  CSV.foreach('./doc/Registered_Committee_List.csv', headers: true) do |row|
    if filers = Filer.where(filer_id: row[0].strip.to_i)
      filers.map do |filer|
        filer.filer_type_code = row[2].strip
        filer.save
      end
    else
      issues.push(row[0].strip.to_i)
    end
  end
  puts issues
end
