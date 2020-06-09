# skyOS

![Verify](https://github.com/lonestarvirtual/skyOS/workflows/Verify/badge.svg)
[![Maintainability](https://api.codeclimate.com/v1/badges/5d90db83c1ed525e2beb/maintainability)](https://codeclimate.com/github/lonestarvirtual/skyOS/maintainability)
[![codecov](https://codecov.io/gh/lonestarvirtual/skyOS/branch/master/graph/badge.svg)](https://codecov.io/gh/lonestarvirtual/skyOS)

skyOS is a [virtual airline](https://en.wikipedia.org/wiki/Virtual_airline_(hobby))
management system written in Rails

## Table of Contents
* [Installation](#installation)
  * [Docker](#docker)
  * [Heroku](#heroku)
  * [Stand-alone](#stand-alone)
* [Configuration](#configuration)
* [Contributing](#contributing)

## Installation
skyOS is easily deployed as Docker container, a Heroku app, or a 
stand-alone application behind a custom environment.

### Docker
Several pre-built image options are available in addition to building a
custom image. 

#### Available tags
* `latest` - Latest released version
* `experimental` - Created on merge to master (pre-release)
* [releases](https://github.com/lonestarvirtual/skyOS/releases) - 
Git tagged version name: `v#.#`

#### Using Compose (recommended)
See [docker-compose.yml.example](docker-compose.yml.example) for an example on
how to use this project with Docker Compose.

When using a registry image, only the `docker-compose.yml` file is necessary.
Customize as necessary and `docker-compose up -d`

#### Building your own image
Clone the repository and build the Docker image using the included Dockerfile:
```
% docker-compose build
```

### Heroku
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

One-click installation is available via the Deploy button above. For demo 
purposes, free resources are selected. Production customization will 
be necessary.

See [Configuration](#configuration) for details on `Config Vars` 
environment variables. The `DATABASE_URL` and `REDIS_URL` are automatically
configured utilizing the add-on mounting in [app.json](app.json)

After the deployment is complete the default administrative credentials are:
  * Username: `admin@example.com`
  * Password: `password`
  
### Stand-alone

Requirements:
* Ruby >=2.6.3
* PostgreSQL >= 10
* Redis
* [ImageMagick](https://imagemagick.org/)

## Configuration
All start-up dependent configuration is managed via environment variables. Any
configuration that can be changed during run-time is managed through the web
interface.

### Environment variables
| Name                  |             | Description                                                               |
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
| SMTP_AUTH             | *optional*  | Defaults to `plain`        

### Rake utilities
Load defaults and create an initial administrative user:
```
# Local console
% rake skyos:install

# On Docker host
% docker-compose run --rm app rake skyos:install
```

*Alternatively* only create an administrative user:
```
# Local console
% rake skyos:create_admin

# On Docker host
% docker-compose run --rm app rake skyos:create_admin
```

*Optionally* populate the airports table (courtesy [OurAirports](https://ourairports.com/))
```
# Local console
% rake skyos:load_airports

# On Docker host
% docker-compose run --rm app rake skyos:load_airports
```

## Contributing

### Development environment
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

### Basic workflow

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Ensure all test pass with appropriate coverage (`COVERAGE=true rake spec`)
4. Lint your changes appropriately (`rubocop`)
5. Check for any new security issues (`brakeman`) 
6. Commit your changes (`git commit -am 'Add some feature'`)
7. Push to the branch (`git push origin my-new-feature`)
8. Create new Pull Request
