#!/bin/bash

cd /var/www

if [ ! -d "faux-cas" ]; then
    echo "Installing payutc/faux-cas"
    git clone -o payutc https://github.com/payutc/faux-cas.git faux-cas
fi

if [ ! -d "faux-ginger" ]; then
    echo "Installing simde-utc/faux-ginger"
    git clone https://github.com/simde-utc/faux-ginger.git faux-ginger
fi

if [ ! -d "server" ]; then
    echo "Installing payutc/server"
    git clone -o payutc https://github.com/payutc/server.git server
    cd server

    echo "Creating config file"
    read -r -d '' SERVER_CONFIG <<'EOF'
sql_host localhost
sql_db payutc
sql_user payutc
sql_pass payutc
cas_url http:\/\/payutc.dev\/faux-cas\/index.php\/
server_url http:\/\/payutc.dev\/server\/web\/
ginger_key fauxginger
ginger_url http:\/\/payutc.dev\/faux-ginger\/index.php\/
EOF
    echo "$SERVER_CONFIG" | sed 's:\(.*\) \(.*\):/\1/s/"[^"]*"/"\2"/:' | sed -f - config.inc.dist.php > config.inc.php

    echo "Installing dependencies"
    curl -sS https://getcomposer.org/installer | php
    php composer.phar install

    echo "Creating database structure"
    php db.php migrations:migrate --no-interaction

    echo "Importing test data"
    mysql -upayutc -ppayutc payutc < dev_data.sql

    echo "Done installing payutc/server"
    cd ..
fi

if [ ! -d "scoobydoo" ]; then
    echo "Installing payutc/scoobydoo"
    git clone -o payutc https://github.com/payutc/scoobydoo.git scoobydoo
    cd scoobydoo
    
    echo "Installing dependencies"
    git submodule init
    git submodule update
    
    # TODO : config
    
    echo "Done installing payutc/scoobydoo"
    cd ..
fi

if [ ! -d "casper" ]; then
    echo "Installing payutc/casper"
    git clone -o payutc https://github.com/payutc/casper.git casper
    cd casper
    git submodule init
    git submodule update
    # TODO : config
    # TODO : composer
    cd ..
fi

if [ ! -d "mozart" ]; then
    echo "Installing payutc/mozart"
    git clone -o payutc https://github.com/payutc/mozart.git mozart
    # TODO : config
fi
