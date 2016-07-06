#!/bin/bash
 
# change HOST and DN to your IP and domain name
#########################################
HOST=10.120.1.231
DN=kemin.haatalk.com
########################################
 
if [ -z "`netstat -nap|grep 3306|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'`" ]; then
    echo 'mysql is not running'
else
    MYSQL_PID=`netstat -nap|grep 3306|awk '/LISTEN/{print}'|grep -v awk|sed '/^$/d'|awk '{print $7}'|awk -F"/" '{print $1}'`
	echo 'stop mysql process'
    kill -9 $MYSQL_PID
	service mysql stop
fi

if [ -n "`/usr/local/ejabberd/bin/ejabberdctl status|grep 'Failed RPC connection to the node ejabberd@kemin: nodedown'`" ]; then
    echo 'ejabber is not running'
else
    echo 'stop ejabberd process'
    /usr/local/ejabberd/bin/ejabberdctl stop
fi
 
echo 'change mysql, nginx configuration'
sed -i "s/10.120.1.231/$HOST/g" /etc/mysql/my.cnf
sed -i "s/kemin.haatalk.com/$DN/g" /etc/nginx/nginx.conf
 
echo 'start mysql, ejabberd'
service mysql start
/usr/local/ejabberd/bin/ejabberdctl start
nginx -s reload
 
exit
