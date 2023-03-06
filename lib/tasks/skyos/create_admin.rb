# frozen_string_literal: true

namespace :skyos do
  desc 'Create an initial admin user'
  task create_admin: :environment do
    pilot = build_pilot
    # rubocop:disable Rails/Output
    if pilot.valid?
      pilot.save
      puts 'The user has been created'
    else
      puts 'The user is not valid'
    end
    # rubocop:enable Rails/Output
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  # rubocop:disable Rails/Output
  def build_pilot
    print 'First name: '
    first_name = $stdin.gets.chomp
    print 'Last name: '
    last_name = $stdin.gets.chomp
    print 'email: '
    email = $stdin.gets.chomp
    print 'Password: '
    password = $stdin.noecho(&:gets).chomp
    puts
    Pilot.new(
      first_name:,
      last_name:,
      email:,
      password:,
      group: Group.find_by(name: 'Admin'),
      active: true,
      confirmed_at: Time.zone.now
    )
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  # rubocop:enable Rails/Output
end
