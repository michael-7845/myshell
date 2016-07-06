#!/bin/bash
 
# 1. get the package
# get the latest package to the current directory by get_release.sh
 
# 2. save the old files to /root/j2ee/old
J2EEDIR=`date +%Y%m%d%H%M%S`
mkdir -p /root/upall/j2ee/$J2EEDIR
cp /root/upall/haatalk_S_0.1_*.war /root/upall/j2ee/$J2EEDIR
mv /usr/local/tomcat/webapps/haatalk.war /root/upall/j2ee/$CURDIR
mv /usr/local/tomcat/webapps/haatalk/ /root/upall/j2ee/$CURDIR

# 3. rename .war to haatalk.war
# !!!!!!!!!!!!!!!!! haatalk_S_0.1_*.war !!!!!!!!!!!!!!!!!
mv /root/upall/haatalk_S_0.1_*.war /root/upall/haatalk.war

# 4. deploy the new .war
mv /root/upall/haatalk.war /usr/local/tomcat/webapps

exit

