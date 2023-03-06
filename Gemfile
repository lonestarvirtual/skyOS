# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '~> 3.2.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0.4.8'
gem 'websocket-extensions', '>= 0.1.5' # CVE-2020-7663
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 5.6'
# Use SCSS for stylesheets
gem 'sassc', '~> 2.3.0'
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 5.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.2', require: false

# SkyOS gems
gem 'devise'
gem 'exception_handler', '~> 0.8.0.0'
gem 'friendly_id', '~> 5.2.4'
gem 'geocoder'
gem 'gravtastic'
gem 'haml-rails', '~> 2.0'
gem 'image_processing', '~> 1.12'
gem 'kaminari'
gem 'net-smtp', require: false
gem 'paper_trail'
gem 'paper_trail-association_tracking', '~> 2.1.3'
gem 'pundit'
gem 'rails-settings-cached', '~> 2.0'
gem 'ransack'
gem 'recaptcha'
gem 'sidekiq'
gem 'simple_form'
gem 'timezone_finder'

group :development, :test do
  gem 'brakeman'
  # Call 'byebug' anywhere in the code to stop execution
  # and get a debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'codecov', require: false
  gem 'database_cleaner-active_record'
  gem 'dotenv-rails'
  gem 'factory_bot_rails'
  gem 'faker', git: 'https://github.com/faker-ruby/faker.git', branch: 'master'
  gem 'pundit-matchers', '~> 1.6.0'
  gem 'rails-controller-testing'
  gem 'rspec-rails', '~> 4.0.0'
  gem 'shoulda-callback-matchers'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  # Access an interactive console on exception pages or
  # by calling 'console' anywhere in the code.
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application
  # running in the background. Read more: https://github.com/rails/spring
  gem 'letter_opener'
  gem 'rubocop-rails', require: false
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
