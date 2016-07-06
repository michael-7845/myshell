#!/bin/bash

## set var from upall.sh
HOST=10.120.1.231
USER=root
PWD=root

# 1. change the j2ee server jdbc properties ; jmail properties; system-config.xml
# jdbc
sed -i "s/10.120.10.21:3306/$HOST:3306/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/jdbc.properties
sed -i "s/database.user=messenger/database.user=$USER/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/jdbc.properties
sed -i "s/database.password=123qwe/database.password=$PWD/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/jdbc.properties
#jmail
sed -i "s/http:\/\/10.120.10.41:4560/http:\/\/localhost:4560/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/jmail.properties
# system-config.xml
sed -i "s/<domain>10.120.10.37<\/domain>/<domain>$HOST<\/domain>/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/system-config.xml
sed -i "s/<user>ckuser<\/user>/<user>kemin<\/user>/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/system-config.xml
sed -i "s/<password>123qwe<\/password>/<password>password<\/password>/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/system-config.xml
sed -i "s/<http_address>http:\/\/10.120.10.37<\/http_address>/<http_address>http:\/\/$HOST<\/http_address>/g" /usr/local/tomcat/webapps/haatalk/WEB-INF/classes/system-config.xml

# 2. change the web server jdbc properties ; system-config.xml ; url.jsp
# jdbc
sed -i "s/10.120.10.21:3306/$HOST:3306/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/jdbc.properties
sed -i "s/database.user=messenger/database.user=$USER/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/jdbc.properties
sed -i "s/database.password=123qwe/database.password=$PWD/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/jdbc.properties
# system-config.xml
sed -i "s/<xmpp_rpc_server>http:\/\/10.120.10.41:4560<\/xmpp_rpc_server>/<xmpp_rpc_server>http:\/\/localhost:4560<\/xmpp_rpc_server>/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/system-config.xml
sed -i "s/<domain>10.120.10.37<\/domain>/<domain>$HOST<\/domain>/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/system-config.xml
sed -i "s/<user>ckuser<\/user>/<user>kemin<\/user>/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/system-config.xml
sed -i "s/<password>123qwe<\/password>/<password>password<\/password>/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/system-config.xml
sed -i "s/<http_address>http:\/\/10.120.10.37<\/http_address>/<http_address>http:\/\/$HOST<\/http_address>/g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/classes/system-config.xml
# url.jsp
sed -i "s/http:\/\/web.haatalk.com\/a\//http:\/\/$DN\/a\//g" /usr/local/tomcat/webapps/haatalk_web/WEB-INF/jsp/include/url.jsp

exit