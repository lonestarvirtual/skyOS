#!/bin/sh

# Check the database state and seed (in the event upgrade)
bundle exec rake db:migrate db:seed

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate/seed. Running setup."
  echo
  bundle exec rake db:setup
fi

# Execute the given or default command:
exec "$@"
