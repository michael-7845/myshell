#!/bin/bash
 
# 1. put the latest Messenger_S_0.1_*.sql to the current directory
# get by get_release.sh

# 2. save the Messenger_S_0.1_*.sql
cp /root/upall/haatalk_S_0.1_*.sql /root/upall/mysql/
mv /root/upall/haatalk_S_0.1_*.sql /root/upall/Messenger_S_0.1.sql
 
# 3. drop Messenger
echo "drop Messenger"
mysql -uroot -proot -e "drop database Messenger"
sleep 1
 
# 4. create Messenger
echo "create Messenger"
mysql -uroot -proot -e "create database Messenger"
sleep 2
mysql -uroot -proot -e "GRANT ALL PRIVILEGES on Messenger.* TO root@'%' IDENTIFIED BY 'root'"
sleep 1
 
# 5. import the new sql
echo "import Messenger"
mysql -uroot -proot Messenger < /root/upall/Messenger_S_0.1.sql
sleep 2
mysql -uroot -proot Messenger < /root/upall/Messenger_IM_Number_20110927.sql
sleep 2
 
# 6. remove Messenger_S_0.1.sql in the current directory
rm /root/upall/Messenger_S_0.1.sql
 
exit