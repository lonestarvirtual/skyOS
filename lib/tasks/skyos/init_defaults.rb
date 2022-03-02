# frozen_string_literal: true

require 'csv'

namespace :skyos do
  desc 'Load default Equipment, Networks and Simulators'
  task init_defaults: :environment do
    # Default equipment types
    #
    equip_csv = File.read(Rails.root.join('lib/seeds/equipment.csv'))
    equip_csv = CSV.parse(equip_csv, headers: true)
    equip_csv.each do |row|
      e = Equipment.new
      e.short_name = row['short_name']
      e.icao = row['icao']
      e.iata = row['iata']
      e.name = row['name']
      e.description = row['description']
      e.save
    end

    # Default networks
    #
    Network.create(name: 'IVAO')
    Network.create(name: 'PilotEdge')
    Network.create(name: 'VATSIM')

    # Default simulators
    #
    Simulator.create(short_name: 'FS2004', name: 'Microsoft Flight Simulator 2004')
    Simulator.create(short_name: 'FSX',    name: 'Microsoft Flight Simulator X')
    Simulator.create(short_name: 'P3Dv3',  name: 'Lockheed Martin Prepar3D v3')
    Simulator.create(short_name: 'P3Dv4',  name: 'Lockheed Martin Prepar3D v4')
    Simulator.create(short_name: 'P3Dv5',  name: 'Lockheed Martin Prepar3D v5')
    Simulator.create(short_name: 'XP10',   name: 'Laminar Research X-Plane 10')
    Simulator.create(short_name: 'XP11',   name: 'Laminar Research X-Plane 11')
  end
end
