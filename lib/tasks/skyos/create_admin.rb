# frozen_string_literal: true

require 'optparse'

namespace :skyos do
  desc 'Create an initial admin user'
  task :create_admin, [:default] => :environment do |_task, args|
    options = args[:default].present? ? default_user : prompt_options
    options.merge!({
                     group: Group.find_by(name: 'Admin'),
                     active: true,
                     confirmed_at: Time.zone.now
                   })

    pilot = Pilot.new(options)

    # rubocop:disable Rails/Output
    if pilot.valid?
      pilot.save
      puts 'The user has been created'
    else
      puts 'ERROR - admin user is not valid:'
      pilot.errors.full_messages.each do |message|
        puts message
      end
    end
    # rubocop:enable Rails/Output
  end

  def default_user
    {
      first_name: 'Default',
      last_name: 'Admin',
      email: 'admin@example.com',
      password: 'password'
    }
  end

  # rubocop:disable Rails/Output
  # rubocop:disable Metrics/MethodLength
  def prompt_options
    options = {}

    print 'First name: '
    options[:first_name] = STDIN.gets.chomp
    print 'Last name: '
    options[:last_name] = STDIN.gets.chomp
    print 'email: '
    options[:email] = STDIN.gets.chomp
    print 'Password: '
    options[:password] = STDIN.noecho(&:gets).chomp
    puts

    options
  end
  # rubocop:enable Rails/Output
  # rubocop:enable Metrics/MethodLength
end
