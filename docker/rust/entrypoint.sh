#!/bin/sh
set +e
echo `date '+%Y/%m/%d %H:%M:%S'` $0 "[INFO] Connection confriming"
while :
do
    result=`/usr/bin/mysqladmin ping -h${DB_HOST} -u${DB_USER} -p${DB_PASSWORD}`

    if echo $result | grep 'alive'; then
        break
    fi

    sleep 1;
done
set -e

if [ ! -f .env ]
then
    echo "DATABASE_URL=mysql://$DB_USER:$DB_PASSWORD@$DB_HOST/$DB_NAME" > .env
fi

if [ ! -d migrations ]
then
    diesel setup
    diesel migration generate init
fi

diesel migration run

cargo run install --path .

app &
