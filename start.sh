#!/bin/sh
echo "Starting mysql and seafile and seahub..."
service mysql start
/opt/seafile/seafile-server-latest/seafile.sh start
/opt/seafile/seafile-server-latest/seahub.sh start 80
echo "Restarting nginx..."
service nginx restart
