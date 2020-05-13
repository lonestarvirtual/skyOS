# frozen_string_literal: true

namespace :skyos do
  desc 'Load defaults and create an initial user'
  task install: :environment do
    # rubocop:disable Rails/Output
    puts 'Welcome to skyOS!'
    # rubocop:enable Rails/Output

    Rake::Task['skyos:init_defaults'].invoke
    Rake::Task['skyos:create_admin'].invoke
  end
end
