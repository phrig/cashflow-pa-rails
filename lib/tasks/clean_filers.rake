require 'csv'

namespace :clean_filers do

  task strip_whitespace: :environment do
    Filer.all.map do |filer|
      filer.attributes.values.map do |value|
        if value.is_a?(String)
          value.strip!
        end
      end
      filer.save
    end
  end

  task create_list_of_duplicates: :environment do

    duped_filers = []
    unique_ids = Filer.all.map(&:filer_id).uniq

    unique_ids.map do |filer_id|
      filer_arr = Filer.where(filer_id: filer_id)
      next if filer_arr.count == 1
      filer_arr.map do |duped_filer|
        duped_filers.push(duped_filer)
      end
    end

    CSV.open("#{Rails.root}/doc/duped_filers.csv", 'wb') do |csv|
      csv << Filer.column_names

      duped_filers.map do |filer|
        csv << filer.attributes.values
      end
    end
  end

end