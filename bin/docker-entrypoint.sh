#!/bin/sh

# Check the database state and seed (in the event of upgrade)
rake db:migrate db:seed

if [[ $? != 0 ]]; then
  echo
  echo "== Failed to migrate/seed. Running setup."
  echo
  rake db:prepare
fi

# Execute the given or default command:
exec "$@"
