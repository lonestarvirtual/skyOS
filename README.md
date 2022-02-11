# SkyOS

![Verify](https://github.com/lonestarvirtual/skyOS/workflows/Verify/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/5d90db83c1ed525e2beb/maintainability)](https://codeclimate.com/github/lonestarvirtual/skyOS/maintainability)
[![codecov](https://codecov.io/gh/lonestarvirtual/skyOS/branch/master/graph/badge.svg)](https://codecov.io/gh/lonestarvirtual/skyOS)

skyOS is a web-based virtual airline management system written in Rails and 
used by [Lonestar Cargo](https://lonestarcargo.org). 

It is an open-source project that may be used by anyone running a [Virtual 
Airline](https://en.wikipedia.org/wiki/Virtual_airline_(hobby)). We 
encourage forks and pull-requests for new features and fixes!

## Development Getting Started

Developed with Ruby: 2.6.9 / Rails: 6

To get the Rails server running locally:

* Clone this repo
* `bundle install` to install required dependencies
* `yarn install --check-files` install front-end dependencies
* configure `.env` file for development/test databases (see `.env.template`)
* `rake db:prepare` to create and seed database
* `rake skyos:install` (optional) create an administrative user and load 
   helpful defaults
* `rake skyos:create_admin` (optional) *instead of `install`* to create an 
   administrative user only.
* `rails s` to start the local server

### External Dependencies

* [ImageMagick](https://imagemagick.org/)

## Getting Started with Docker

### Container Images

#### From repository

This repository builds and releases a Docker image to our GitHub Docker
repository. See [docker-compose.yml.example](docker-compose.yml.example) for an
example on how to pull the latest release and customize for your production 
environment.

#### Building your own image

This repository comes equipped to be run within Docker. The easiest way to 
build your own image is using [docker-compose](https://docs.docker.com/compose/). 

Build the Docker image using:

```
% docker-compose build
```

### Configuration

On first boot, the image will connect to the database specified in your 
`docker-compose.yml` or to the PostgreSQL server specified via environment
variables (see [docker-compose.yml.example](docker-compose.yml.example))

Load defaults and create an initial administrative user:

```
% docker-compose run --rm app rake skyos:install
```

*Optionally* populate the airports table (courtesy [OurAirports](https://ourairports.com/))

```
% docker-compose run --rm app rake skyos:load_airports
```

After setting up, you can run the application and dependencies:

```
% docker-compose up -d
```

## Configuration

### Environment Variables

| Syntax                |             | Description                                                               |
| :---                  |   :----:    | :-----------                                                              |
| DATABASE_URL          |**required** | Database URL see [docker-compose.yml.example](docker-compose.yml.example) |
| RAILS_HOSTNAME        |**required** | External hostname for application                                         |
| REDIS_URL             |**required** | Redis URL see [docker-compose.yml.example](docker-compose.yml.example)    |
| SECRET_KEY_BASE       |**required** | Key used to sign messages and encrypt cookies                             |
| SMTP_SERVER           |**required** | Mail server, example: `smtp.example.com`                                  |
| SMTP_PORT             | *optional*  | Mail server port, default: `25`                                           |
| SMTP_DOMAIN           | *optional*  | Defaults to `RAILS_HOSTNAME`                                              |
| SMTP_USERNAME         |**required** | Mail service username                                                     |
| SMTP_PASSWORD         |**required** | Mail service password                                                     |
| SMTP_AUTH             | *optional*  | Defaults to `plain`                                                       |

### Rails Settings

The `Setting` model contains settings that can be changed while the application
is running. Administration of these settings can be performed live by visiting
the `Admin -> Settings` page while logged in with an appropriate user account. 

See `app\models\setting.rb` for defaults.

### Initial administrator

When users are registered, they automatically join the default Pilot user group.
To create an initial administrative user run the following rake task:

```
rake skyos:create_admin
```

This will prompt you for the user attributes and assign the user administrative
privileges.

## Upgrading

### Docker

[docker-entrypoint.sh](/bin/docker-entrypoint.sh) runs at container start and 
will automatically attempt to migrate and seed the database with changes as
necessary.

### Manual

If the app is using a different environment then it may be necessary to run the 
following steps after upgrade:

```
rake db:migrate
rake db:seed
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure all test pass with appropriate coverage (`COVERAGE=true rake spec`)
4. Lint your changes appropriately (`rubocop`)
5. Check for any new security issues (`brakeman`) 
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request
