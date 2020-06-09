#!/bin/sh

echo "-- skyOS post deploy initialization --"

echo "Creating and seeding the database"
bundle exec rake db:prepare

echo "Initializing default options"
bundle exec rake skyos:init_defaults

echo "Creating the default admin user"
bundle exec rake skyos:create_admin[default]
