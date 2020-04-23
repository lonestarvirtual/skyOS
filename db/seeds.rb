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
models = %w(Airline Airport Equipment Fleet Flight Group Pilot Simulator)

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

# Default administrator
#
admin_attributes = {
    pid:        0,
    first_name: 'Default',
    last_name:  'Administrator',
    email:      "admin@skyos",
    password:   'deleteme',
    group:      Group.find_by(name: 'Admin')
}

admin = Pilot.new(admin_attributes)
admin.skip_confirmation!
admin.save!

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

# Default simulators
#
Simulator.create(short_name: 'FS2004', name: 'Microsoft Flight Simulator 2004')
Simulator.create(short_name: 'FSX', name: 'Microsoft Flight Simulator X')
Simulator.create(short_name: 'P3Dv3', name: 'Lockheed Prepar3D v3')
Simulator.create(short_name: 'P3Dv4', name: 'Lockheed Prepar3D v4')
Simulator.create(short_name: 'P3Dv5', name: 'Lockheed Prepar3D v5')
Simulator.create(short_name: 'XP10', name: 'Laminar Research X-Plane 10')
Simulator.create(short_name: 'XP11', name: 'Laminar Research X-Plane 11')
