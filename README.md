# SkyOS

[![Build Status](https://travis-ci.com/lonestarvirtual/skyOS.svg?token=K5U93Dpwry1XesnyC3r8&branch=development)](https://travis-ci.com/lonestarvirtual/skyOS)

skyOS is the web presence of Lonestar Virtual

## Development Getting Started

Developed with Ruby: 2.6.3p62 / Rails: 6.0.2.2

To get the Rails server running locally:

* Clone this repo
* `bundle install` to install required dependencies
* `yarn install --check-files` install front-end dependencies
* `rake db:setup` to create and seed database
* `rails s` to start the local server

### External Dependencies

* [ImageMagick](https://imagemagick.org/)

## Configuration

This site uses the Rails encrypted credential store. The following
credentials may be configured with `rails credentials:edit`

```yaml
# Google Analytics
# Remove entire section/environment or leave blank to disable
google_analytics:
  development:
    tracking_id: UA-XXXXXXX-X
  production:
    tracking_id: UA-XXXXXXX-X

# Google reCAPTCHA
# Remove section/environment or leave blank to disable
google_recaptcha:
  development:
    site_key: <SITE_KEY>
    secret_key: <SECRET_KEY>
  production:
    site_key: <SITE_KEY> 
    secret_key: <SECRET_KEY>
```

### Environment Variables

| Syntax                |             | Description                                                        |
| :---                  |   :----:    | :-----------                                                       |
| RAILS_HOSTNAME        |**required** | External hostname for application                                  |
| RAILS_MASTER_KEY      |**required** | Master key used for credential store                               |

### Rails Settings

The `Setting` model contains settings that can be changed while the application
is running.

| Key                   | Description                                              |
| :-------------------- | :------------------------------------------------------- |
| admin_emails          | Array of staff emails (used for contact us page requests |
| allow_signup          | Turn on or off new user registration (default true)      |
| organization_icao     | Set the organization ICAO (callsign) for Pilot IDs, etc  |
| recaptcha_min_score   | Minimum reCAPTCHA v3 score, values 0 - 1 (default 0.5)   |
| reply_to              | From address used for default mailer correspondence      |

### Initial administrator

When the database is seeded a temporary administrative 'pilot' user is created.
This account should only be used long enough to on board an initial real user
and then deleted.

* Username: `admin@skyos`
* Password: `deleteme`
