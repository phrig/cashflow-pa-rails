require 'csv'

namespace :filer_data do

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

  task compare_csv_data: :environment do

    CSV.foreach('./doc/Registered_Committee_List.csv', headers: true) do |row|
      filers = Filer.where(filer_id: row[0])

      unless filers.count == 1
        filers.uniq.map do |filer|
          puts "id: #{filer.id} ==> filer_id: #{filer.filer_id} ==> #{filer.filer_name}"
        end
      end
    end
  end

end