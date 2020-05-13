#!/bin/sh

# Check the database state and seed (in the event of upgrade)
bundle exec rake db:migrate db:seed

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate/seed. Running setup."
  echo
  bundle exec rake db:prepare
fi

# Execute the given or default command:
exec "$@"
