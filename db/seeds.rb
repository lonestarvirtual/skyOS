# frozen_string_literal: true

#
# !!THIS FILE SHOULD ONLY CONTAIN CRITICAL ITEMS FOR OPERATION OF THE SITE!!
# Other defaults should be placed in the Rake task skyos/init_defaults
#
# The DB will be routinely seeded during Docker container startup to ensure
# seamless upgrades. Only uniquely keyed information should be placed here.
#

# Permissions
#
%w(
  Airline
  Airport
  Announcement
  Equipment
  Fleet
  Flight
  Group
  Network
  Pilot
  Pirep
  Setting
  Simulator
).each do |model|
  %w( create read update destroy ).each do |action|
    Permission.find_or_create_by(
        model:        model,
        action:       action,
        description:  "#{action.titleize} #{model.pluralize}"
        )
  end
end

# Groups
#
Group.find_or_create_by(name: 'Admin', description: 'Administrators group')
Group.find_or_create_by(name: 'Pilot', description: 'Default user/pilot group')

# Admin Group Permissions
admin_group = Group.find_by(name: 'Admin')
admin_group.update_attribute(:permissions, Permission.all)

# PIREP Statuses
#
[
    {
        name:     'Draft',
        editable: true,
        approved: false,
        pending:  false,
        color:    '#a0ffd8',
        sequence: 1
    },
    {
        name:     'Submitted',
        editable: false,
        approved: false,
        pending:  true,
        color:    '#efefbf',
        sequence: 2
    },
    {
        name:     'Approved',
        editable: false,
        approved: true,
        pending:  false,
        color:    '',
        sequence: 4
    },
    {
        name:     'Rejected',
        editable: false,
        approved: false,
        pending:  false,
        color:    '#ffc0c0',
        sequence: 5
    }
].each do |status|
  PirepStatus.find_or_create_by(status)
end
