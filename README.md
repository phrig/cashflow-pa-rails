# Cheapest Seats in PA

## Prerequisites

- Git
- Ruby 2.3.4
- rvm
- postgres

## Run the app in development

Once you have `rvm` and `ruby 2.3.4` installed,

    git clone git@github.com:phrig/cheapest_seats.git
    bundle install

Copy the environment variables and secrets into their appropriate place and oyt in production data:

    cp .env.example .env
    cp /config/database.yml.example /config/database.yml
    cp /config/secrets.yml.example /config/secrets.yml
    rails db:create
    rails db:migrate

Run the server

    rails s

Run the console
    rails c

Import the data

    rake import:all

## Contribution workflow

Use a feature branch. When you want to make a contribution, do a `git fetch` and `pull` to get the latest version of `master`. Then re-base your branch, resolve any conflicts that may occur, and then make a pull request.




