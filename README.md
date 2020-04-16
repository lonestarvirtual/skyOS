skyOS is the web presence of Lonestar Virtual

## Development Getting Started

Developed with Ruby: 2.6.3p62 / Rails: 6.0.2.2

To get the Rails server running locally:

* Clone this repo
* `bundle install` to install required dependencies
* `yarn install --check-files` install front-end dependencies
* `rake db:setup` to create and seed database
* `rails s` to start the local server

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
```

## Environment Variables

| Syntax                |             | Description                          |
| :---                  |   :----:    | :-----------                         |
| RAILS_MASTER_KEY      |**required** | Master key used for credential store |
| RECAPTCHA_SITE_KEY    | *optional*  | Google reCAPTCHA site key (v3)       |
| RECAPTCHA_SECRET_KEY  | *optional*  | Google reCAPTCHA secret key (v3)     |
