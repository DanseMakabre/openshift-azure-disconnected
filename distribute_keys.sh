#/bin/bash

password=$1

for i in master.example.com infra.example.com node1.example.com node2.example.com
do
  ssh-keyscan $i >> /root/.ssh/known_hosts  
  sshpass -p "$password" ssh-copy-id $i
done
