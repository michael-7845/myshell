#!/bin/bash

# set var according to your env
################################
HOST=10.120.1.231
USER=root
PWD=root
DN=kemin.haatalk.com
################################

declare -i isTOMRunning
# 0 stopped; 1 running
isTOMRunning=1

export HOST
export USER
export PWD
export DN

$CURDIR=`pwd`
cd /root/upall/

echo 'get the specified release'
/root/upall/get_release.sh

echo 'update mysql'
/root/upall/ch_mysql.sh

# stop_tomcat
if [ -z "`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    echo 'tomcat not running'
    isTOMRunning=0
else
    TOMPID=`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'|awk '{print $7}'|awk -F"/" '{print $1}'`
    kill -9 $TOMPID
fi
while [ "$isTOMRunning" = "1" ]
do
  if [ -z "`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    echo 'tomcat not running'
    isTOMRunning=0
  fi
  sleep 1
done
sleep 15

echo 'deploy new android server'
/root/upall/dep_j2ee.sh
echo 'deploy new web server'
/root/upall/dep_web.sh

# start_tomcat
cd /usr/local/tomcat/bin
./startup.sh
while [ "$isTOMRunning" = "0" ]
do
  if [ -n "`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    if [ -d /usr/local/tomcat/webapps/haatalk ]; then
	  if [ -d /usr/local/tomcat/webapps/haatalk_web ]; then
        echo 'tomcat running'
        isTOMRunning=1
	  fi
	fi
  fi
  sleep 2
done
sleep 20

# stop_tomcat
if [ -z "`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    echo 'tomcat not running'
    isTOMRunning=0
else
    TOMPID=`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'|awk '{print $7}'|awk -F"/" '{print $1}'`
    kill -9 $TOMPID
fi
while [ "$isTOMRunning" = "1" ]
do
  if [ -z "`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    echo 'tomcat not running'
    isTOMRunning=0
  fi
  sleep 1
done
sleep 15

echo 'modify android server default configuration'
echo 'modify web server default configuration'
/root/upall/ch_webapp.sh

# start_tomcat
cd /usr/local/tomcat/bin
./startup.sh
while [ "$isTOMRunning" = "0" ]
do
  if [ -n "`netstat -nap|grep 8080|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    echo 'tomcat running'
    isTOMRunning=1
  fi
  sleep 1
done

ls /root/upall/haatalk_* && rm -f /root/upall/haatalk_*
cd $CURDIR
exit
