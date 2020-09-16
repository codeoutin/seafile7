#!/bin/bash
if [ -d "/opt/seafile" ]
then
    echo "Seafile is already installed. Skip Setup..."
else
    service mysql start
    # Run Seafile setup
    wget --no-check-certificate https://raw.githubusercontent.com/haiwen/seafile-server-installer/master/seafile_ubuntu
    echo "1" | bash ./seafile_ubuntu 7.0.5

    echo "Stopping Seafile & Moving directories"
    /opt/seafile/seafile-server-latest/seahub.sh stop
    /opt/seafile/seafile-server-latest/seafile.sh stop

    echo "Move folders to /shared and create symlinks"
    mkdir -p /shared/seafile
    mkdir -p /shared/logs

    # CCNET
    if [ -d "/shared/seafile/ccnet" ]
    then
        echo "Path /shared/seafile/ccnet already exists. Create only symlinks"
        rm -rf /opt/seafile/ccnet
        ln -s /shared/seafile/ccnet /opt/seafile/ccnet
    else
        mv /opt/seafile/ccnet /shared/seafile/ccnet && ln -s /shared/seafile/ccnet /opt/seafile/ccnet
    fi

    # CONF
    if [ -d "/shared/seafile/conf" ]
    then
        echo "Path /shared/seafile/conf already exists. Create only symlinks"
        rm -rf /opt/seafile/conf
        ln -s /shared/seafile/conf /opt/seafile/conf
    else
        mv /opt/seafile/conf /shared/seafile/conf && ln -s /shared/seafile/conf /opt/seafile/conf
    fi

    # LOGS
    if [ -d "/shared/logs/seafile" ]
    then
        echo "Path /shared/logs/seafile already exists. Clear logs and create symlinks"
        rm -rf /shared/logs/seafile/* && rm -rf /opt/seafile/logs
        ln -s /shared/logs/seafile /opt/seafile/logs
    else
        mv /opt/seafile/logs /shared/logs/logs && mv /shared/logs/logs /shared/logs/seafile && ln -s /shared/logs/seafile /opt/seafile/logs
    fi

    # SEAFILE-DATA
    if [ -d "/shared/seafile/seafile-data" ]
    then
        echo "Path /shared/seafile/seafile-data already exists. Create only symlinks"
        rm -rf /opt/seafile/seafile-data
        ln -s /shared/seafile/seafile-data /opt/seafile/seafile-data
    else
        mv /opt/seafile/seafile-data /shared/seafile/seafile-data && ln -s /shared/seafile/seafile-data /opt/seafile/seafile-data
    fi

    # SEAHUB-DATA
    if [ -d "/shared/seafile/seahub-data" ]
    then
        echo "Path /shared/seafile/seahub-data already exists. Create only symlinks"
        rm -rf /opt/seafile/seahub-data
        ln -s /shared/seafile/seahub-data /opt/seafile/seahub-data
    else
        mv /opt/seafile/seahub-data /shared/seafile/seahub-data && ln -s /shared/seafile/seahub-data /opt/seafile/seahub-data
    fi

    # DB
    service mysql stop
    if [ -d "/shared/db" ]
    then
        echo "Path /shared/seafile/ccnet already exists. Create only symlinks"
        mv /var/lib/mysql /var/lib/mysql_old
        ln -s /shared/db /var/lib/mysql
    else
        echo "Moving DB Folder..."
        mv /var/lib/mysql /shared && mv /shared/mysql /shared/db && ln -s /shared/db /var/lib/mysql
    fi

    echo "Setup complete. Login credentials saved in /shared/logs"
    cp /opt/seafile/aio_seafile-server.log /shared/logs/setup.log

    echo "Starting Seafile services"
    chown -R root:root /shared/logs
    chown -R root:root /shared/seafile
    chown -R root:root /opt/seafile
fi
