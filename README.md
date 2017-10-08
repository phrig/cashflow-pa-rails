# Cash Flow, PA

## Prerequisites

- Git
- Ruby 2.3.4
- rvm
- postgres

## Run the app in development

Once you have `rvm` and `ruby 2.3.4` installed,

    git clone git@github.com:phrig/cash_flow_pa.git
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

To import one data set, consult `lib/tasks/import_data.rake` for individual tasks.

## SSH and deploying the application

First, make sure you have put the secret key in the right place. Consult `doc/ssh-conf` to set the correct `ssh alias`.

To deploy

    cap production deploy

## Contribution workflow

Use a feature branch. When you want to make a contribution, do a `git fetch` and `pull` to get the latest version of `master`. Then re-base your branch, resolve any conflicts that may occur, and then make a pull request.




