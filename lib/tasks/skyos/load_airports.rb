# frozen_string_literal: true

require 'csv'

namespace :skyos do
  desc 'Load airports from OurAirports'
  task load_airports: :environment do
    cntry_url = URI.open('https://ourairports.com/data/countries.csv')
    arpts_url = URI.open('https://ourairports.com/data/airports.csv')

    # cntry_url = URI.open('tmp/countries.csv')
    # arpts_url = URI.open('tmp/airports.csv')

    tf = TimezoneFinder.create

    #### Countries
    countries = {}

    CSV.foreach(cntry_url, headers: true, header_converters: :symbol) do |row|
      countries[row[:code]] = row[:name]
    end
    ####

    # puts 'icao,iata,name,city,latitude,longitude'

    CSV.foreach(arpts_url, headers: true, header_converters: :symbol) do |row|
      next unless (row[:ident].size <= 4) || row[:ident].blank?
      next if row[:type] == 'balloonport'
      next if row[:type] == 'heliport'
      next if row[:type] == 'closed'
      next if row[:type] == 'seaplane_base'

      next unless row[:iata_code].present? || row[:type] != 'small_airport'

      next if row[:municipality].blank?

      row[:iso_region] =~ /\w+-(\w+)/
      row[:region] = Regexp.last_match(1)

      if row[:iso_country] == 'US'
        row[:city] = "#{row[:municipality]} #{row[:region]}"
      else
        country = countries[row[:iso_country]]
        row[:city] = "#{row[:municipality]} #{country}"
      end

      a = Airport.find_or_initialize_by(icao: row[:ident])
      a.iata      = row[:iata_code]
      a.name      = row[:name]
      a.city      = row[:city]
      a.latitude  = row[:latitude_deg]
      a.longitude = row[:longitude_deg]

      # certain_timezone_at will take longer but more accurate
      #
      tz = tf.certain_timezone_at(lat: a.latitude, lng: a.longitude)
      a.time_zone = tz.to_s

      a.save if a.changed?
    end
  end
end
