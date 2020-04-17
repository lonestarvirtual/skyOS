# frozen_string_literal: true
# This file should contain all the record creation needed to seed the
# database with its default values. The data can then be loaded with
# the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#  movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#  Character.create(name: 'Luke', movie: movies.first)

Group.create(name: 'Admin', description: 'Administrators group')
Group.create(name: 'Pilot', description: 'Default user/pilot group')

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
