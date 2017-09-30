# Cheapest Seats in PA

## Prerequisites

- Git
- Ruby 2.4.2
- rvm
- postgres

## Run the app in development

Once you have `rvm` and `ruby 2.4.2` installed,

`git clone git@github.com:phrig/cheapest_seats.git`
`bundle install`

Copy the environment variables and secrets into their appropriate place and oyt in production data:

`cp .env.example .env`
`cp /config/database.yml.example /config/database.yml`
`cp /config/secrets.yml.example /config/secrets.yml`
