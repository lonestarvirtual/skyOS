# frozen_string_literal: true

require 'rake/clean'

namespace :spec do
  Rake::Cleaner.cleanup_files(['coverage'])

  desc 'Run all specs and generate coverage report'
  task coverage: :environment do
    ENV['COVERAGE'] = 'true'
    Rake::Task['spec'].invoke
  end
end
