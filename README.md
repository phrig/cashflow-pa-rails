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

## Take a snapshot of the database and import the data into your development database

SSH into the server and run the following command from the home directory:

    pg_dump --no-acl --no-owner --clean cash_flow_pa | gzip > "cash_flow_pa_`date -u +'%Y-%m-%dT%H-%M-%SZ'`.sql.gz"

In the home directory, run `ls` and make note of the new db snapshot name. Then download the snapshot to your local machine:

    scp cash_flow:{SNAPSHOT_NAME} db/

Gunzip the production db snapshot into your local database:

    gunzip -c db/{SNAPSHOT_NAME} | psql cash_flow_pa_development

If you are setting up the project for the first time, or you want to blow away your local database and start over, do it in this order:

    rake db:drop
    rake db:create
    gunzip -c db/{SNAPSHOT_NAME} | psql cash_flow_pa_development
    rake db:migrate

## Contribution workflow

Use a feature branch. When you want to make a contribution, do a `git fetch` and `pull` to get the latest version of `master`. Then re-base your branch, resolve any conflicts that may occur, and then make a pull request.




