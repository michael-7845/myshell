#!/bin/bash

# 1. get the package
# put the latest package to the current directory by get_release.sh
 
# 2. save the old files to /root/web/old
WEBDIR=`date +%Y%m%d%H%M%S`
mkdir -p /root/upall/web/$WEBDIR
cp /root/upall/haatalk_W_0.1_*.war /root/upall/web/$WEBDIR
mv /usr/local/tomcat/webapps/haatalk_web.war /root/upall/web/$WEBDIR
mv /usr/local/tomcat/webapps/haatalk_web /root/upall/web/$WEBDIR

# 3. rename .war to haatalk_web.war
mv /root/upall/haatalk_W_0.1_*.war /root/upall/haatalk_web.war

# 4. deploy the new .war
mv /root/upall/haatalk_web.war /usr/local/tomcat/webapps
 
exit
