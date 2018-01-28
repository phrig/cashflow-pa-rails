require 'csv'

task add_filer_code: :environment do

  CSV.foreach('./doc/Registered_Committee_List.csv', headers: true) do |row|
    if filer = Filer.find_by_filer_id(row[0])
      filer.filer_type_code = row[2]
      filer.save
    end
  end

  # fix filer names
  Filer.all.map do |filer|
    filer.filer_name.strip
    filer.save
  end

end