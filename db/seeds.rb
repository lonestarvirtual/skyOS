# frozen_string_literal: true
# This file should contain all the record creation needed to seed the
# database with its default values. The data can then be loaded with
# the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)

require 'csv'

# Defined Permissions
#
models = %w(Airline Airport Equipment Fleet Flight Group Network Pilot Pirep Simulator)

models.each do |model|
  Permission.create(model: model, action: 'create',  description: "Create #{model}s")
  Permission.create(model: model, action: 'read',    description: "Read #{model}s")
  Permission.create(model: model, action: 'update',  description: "Update #{model}s")
  Permission.create(model: model, action: 'destroy', description: "Delete #{model}s")
end

# Default Groups
#
Group.create(name: 'Admin', description: 'Administrators group')
Group.create(name: 'Pilot', description: 'Default user/pilot group')

# Default Group Permissions
admin_group = Group.find_by(name: 'Admin')
admin_group.update_attribute(:permissions, Permission.all)

# Default equipment types
#
equip_csv = File.read(Rails.root.join('lib', 'seeds', 'equipment.csv'))
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

# PIREP Statuses
#
PirepStatus.create(name: 'Draft',     editable: true,  approved: false, pending: false, color: '#a0ffd8', sequence: 1)
PirepStatus.create(name: 'Submitted', editable: false, approved: false, pending: true,  color: '#efefbf', sequence: 2)
PirepStatus.create(name: 'Held',      editable: false, approved: false, pending: false, color: '#ffefc0', sequence: 3)
PirepStatus.create(name: 'Approved',  editable: false, approved: true,  pending: false, color: '',        sequence: 4)
PirepStatus.create(name: 'Rejected',  editable: false, approved: false, pending: false, color: '#ffc0c0', sequence: 5)
