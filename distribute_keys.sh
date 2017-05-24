#/bin/bash

logfile="/var/log/${0}.log"
password=$1

logfile=$$.log
exec > $logfile 2>&1

for i in master.example.com infra.example.com node1.example.com node2.example.com
do
  ssh-keyscan $i >> /root/.ssh/known_hosts  
  sshpass -p "$password" ssh-copy-id $i
done
