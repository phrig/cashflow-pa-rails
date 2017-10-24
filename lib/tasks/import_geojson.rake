require 'fileutils'
require 'json'

desc "Import geojson from files into db."

namespace :import_geojson do

  task all: [:congressional_districts, :counties, :house_districts, :senate_districts]

  task congressional_districts: :environment do
    desc "Import all contressional districts"
    file = File.read("#{Rails.root}/doc/PA_congressional_districts.geojson")
    congressional_district_data = JSON.parse(file)
    congressional_district_data['features'].each do |feature|
      congressional_district = CongressionalDistrict.new
      congressional_district.c_first_name = feature['properties']['C_FIRSTNAM']
      congressional_district.c_last_name = feature['properties']['C_LASTNAME']
      congressional_district.home_county = feature['properties']['HOME_COUNT']
      congressional_district.party = feature['properties']['PARTY']
      congressional_district.legislative_district = feature['properties']['LEG_DISTRI']
      congressional_district.feature = feature
      if congressional_district.save
        puts "#{congressional_district.legislative_district} successfully saved."
      else
        puts "Something went wrong saving #{feature['properties']['LEG_DISTRI']}"
      end
    end
  end

  task counties: :environment do
    desc "Import all counties"
    file = File.read("#{Rails.root}/doc/PA_counties.geojson")
    county_data = JSON.parse(file)
    county_data['features'].each do |feature|
      county = County.new
      county.county_fips = feature['properties']['FIPS_COUNT']
      county.county_name = feature['properties']['COUNTY_NAM']
      county.feature = feature
      if county.save
        puts "#{county.county_name} successfully saved."
      else
        puts "Something went wrong saving #{feature['properties']['COUNTY_NAM']}"
      end
    end
  end

  task house_districts: :environment do
    desc "Import all conressional districts"
    file = File.read("#{Rails.root}/doc/PA_house.geojson")
    house_district_data = JSON.parse(file)
    house_district_data['features'].each do |feature|
      house_district = HouseDistrict.new
      house_district.h_first_name = feature['properties']['H_FIRSTNAM']
      house_district.h_last_name = feature['properties']['H_LASTNAME']
      house_district.home_county = feature['properties']['HOME_COUNT']
      house_district.party = feature['properties']['PARTY']
      house_district.legislative_district = feature['properties']['LEG_DISTRI']
      house_district.feature = feature
      if house_district.save
        puts "#{house_district.legislative_district} successfully saved."
      else
        puts "Something went wrong saving #{feature['properties']['LEG_DISTRI']}"
      end
    end
  end

  task senate_districts: :environment do
    desc "Import all senatorial districts"
    file = File.read("#{Rails.root}/doc/PA_senatorial.geojson")
    senate_district_data = JSON.parse(file)
    senate_district_data['features'].each do |feature|
      senate_district = SenateDistrict.new
      senate_district.s_first_name = feature['properties']['S_FIRSTNAM']
      senate_district.s_last_name = feature['properties']['S_LASTNAME']
      senate_district.home_county = feature['properties']['HOME_COUNT']
      senate_district.party = feature['properties']['PARTY']
      senate_district.legislative_district = feature['properties']['LEG_DISTRI']
      senate_district.feature = feature
      if senate_district.save
        puts "#{senate_district.legislative_district} successfully saved."
      else
        puts "Something went wrong saving #{feature['properties']['LEG_DISTRI']}"
      end
    end
  end

end
