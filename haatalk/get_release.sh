#!/bin/bash

CURDIR=`pwd`
cd /root/upall/

wget http://10.120.10.100:9006/S/
mv /root/upall/index.html /root/upall/index.html.s
wget http://10.120.10.100:9006/A/
mv /root/upall/index.html /root/upall/index.html.a

if [ -f /root/upall/index.html.s ]; then
    echo 'getting server war index ok'
else
    echo 'getting server war index failed'
	cd $CURDIR
	exit 1
fi

if [ -f /root/upall/index.html.a ]; then
    echo 'getting apk index ok'
else
    echo 'getting apk index failed'
	cd $CURDIR
	exit 1
fi

echo "version date, i.e. which day release, e.g. 20111019"
read VERSION_DATE
if [ -z $VERSION_DATE ] ; then
  echo "Must specify your version date"
  cd $CURDIR
  exit 1
fi

NEW_A_SER_WAR=`cat /root/upall/index.html.s|grep .war|awk -F'"' '{print $2}'|grep 'haatalk_S_0.1_'|grep _02|grep $VERSION_DATE`
echo $NEW_A_SER_WAR
NEW_DB_SQL=`cat /root/upall/index.html.s|grep .sql|awk -F'"' '{print $2}'|grep 'haatalk_S_0.1_'|grep _02|grep $VERSION_DATE`
echo $NEW_DB_SQL
NEW_W_SER_WAR=`cat /root/upall/index.html.s|grep .war|awk -F'"' '{print $2}'|grep 'haatalk_W_0.1_'|grep _02|grep $VERSION_DATE`
echo $NEW_W_SER_WAR

wget http://10.120.10.100:9006/S/$NEW_A_SER_WAR
wget http://10.120.10.100:9006/S/$NEW_DB_SQL
wget http://10.120.10.100:9006/S/$NEW_W_SER_WAR

if [ ! -f /root/upall/$NEW_A_SER_WAR ]; then
    echo "getting $NEW_A_SER_WAR failed"
	cd $CURDIR
    exit 1
fi
if [ ! -f /root/upall/$NEW_DB_SQL ]; then
    echo "getting $NEW_DB_SQL failed"
	cd $CURDIR
    exit 1
fi
if [ ! -f /root/upall/$NEW_W_SER_WAR ]; then
    echo "getting $NEW_W_SER_WAR failed"
	cd $CURDIR
    exit 1
fi

rm /root/upall/index.html.s
rm /root/upall/index.html.a
cd $CURDIR
exit

