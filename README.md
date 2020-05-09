# SkyOS

![Verify](https://github.com/lonestarvirtual/skyOS/workflows/Verify/badge.svg)

skyOS is the web presence of Lonestar Virtual

## Development Getting Started

Developed with Ruby: 2.6.3 / Rails: 6

To get the Rails server running locally:

* Clone this repo
* `bundle install` to install required dependencies
* `yarn install --check-files` install front-end dependencies
* configure `.env` file for development/test databases (see `.env.template`)
* `rake db:setup` to create and seed database
* `rails s` to start the local server

### External Dependencies

* [ImageMagick](https://imagemagick.org/)

## Getting Started with Docker

### Using a release

This repository builds and releases a Docker image to our GitHub Docker
repository. See `docker-compose.yml.example` for an example on how to pull
the latest release and customize for your production environment.

### Building your own image

This repository comes equipped to be run within Docker. You will need 
`docker-compose` to build the image. An example ```docker-compose.yml```
is included.

Build the Docker image using:

```
% docker-compose build
```

On first boot, you will need to setup and seed the database:

```
% docker-compose run --rm app rake db:setup 
```

After setting up, you can run the application and dependencies:

```
% docker-compose up -d
```

## Configuration

This site uses the Rails encrypted credential store per environment. The 
following credentials may be configured with 
`rails credentials:edit --environment development`

```yaml
# Google Analytics
# Remove entire section/environment or leave blank to disable
google_analytics:
  tracking_id: UA-XXXXXXX-X

# Google reCAPTCHA
# Remove section/environment or leave blank to disable
google_recaptcha:
  site_key: <SITE_KEY> 
  secret_key: <SECRET_KEY>

# Mail server settings
smtp:
  address: 'smtp.server.com'
  domain: 'this-app.com'
  username: 'someuser@this-app.com'
  password: 'password'
```

### Environment Variables

| Syntax                |             | Description                                         |
| :---                  |   :----:    | :-----------                                        |
| RAILS_HOSTNAME        |**required** | External hostname for application                   |
| RAILS_MASTER_KEY      |**required** | Master key used for credential store                |
| SKY_OS_REPLY_TO       |**required** | From address used for default mailer correspondence |

### Rails Settings

The `Setting` model contains settings that can be changed while the application
is running.

| Key                   | Description                                              |
| :-------------------- | :------------------------------------------------------- |
| admin_emails          | Array of staff emails (used for contact us page requests |
| allow_signup          | Turn on or off new user registration (default true)      |
| organization_icao     | Set the organization ICAO (callsign) for Pilot IDs, etc  |
| recaptcha_min_score   | Minimum reCAPTCHA v3 score, values 0 - 1 (default 0.5)   |

### Initial administrator

When users are registered, they automatically join the default Pilot user group.
To create an initial administrative user run the following rake task:

```
rake skyos:create_admin
```

This will prompt you for the user attributes and assign the user administrative
privileges.
