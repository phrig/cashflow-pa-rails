### Steps performed to set up a Capistrano environment on Ubuntu 16.04:

    gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3

    \curl -sSL https://get.rvm.io | bash

    source /home/ubuntu/.rvm/scripts/rvm

    rvm install ruby-2.2.0

    sudo mkdir -p /rails/cansurround

    sudo chown -R ubuntu:ubuntu /rails

    rvm use ruby-2.2.0

    sudo sh -c 'echo deb http://apt.postgresql.org/pub/repos/apt/ xenial-pgdg main > /etc/apt/sources.list.d/pgdg.list'

    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | sudo apt-key add -

    sudo apt-get update

    sudo apt-get -y install postgresql-9.3 postgresql-client-9.3 postgresql-server-dev-9.3

    sudo -u postgres createuser ubuntu

    sudo -u postgres bash -c "echo 'CREATE DATABASE cash_flow_pa WITH OWNER = ubuntu' | psql"

    scp cash_flow_pa_development_2017-10-10T02-03-21Z.sql.gz ubuntu@54.198.139.141:~/ (move local db to remote)

    gem install bundler --no-ri --no-rdoc

    # Passenger install
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 561F9B9CAC40B2F7
    sudo apt-get install -y apt-transport-https ca-certificates
    sudo sh -c 'echo deb https://oss-binaries.phusionpassenger.com/apt/passenger xenial main > /etc/apt/sources.list.d/passenger.list'
    sudo apt-get update
    sudo apt-get install -y nginx-extras passenger nodejs
    sudo sed -i 's/\(\s\+\)# \(include \/etc\/nginx\/passenger.conf\)/\1\2/' /etc/nginx/nginx.conf
    sudo service nginx restart
    sudo /usr/bin/passenger-config validate-install

    # After tweaking the config file
    sudo ln -s /etc/nginx/sites-available/cansurround /etc/nginx/sites-enabled/ && sudo rm /etc/nginx/sites-enabled/default && sudo service nginx restart
