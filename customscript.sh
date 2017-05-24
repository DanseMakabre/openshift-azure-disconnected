#/bin/bash

password=$1

logfile=$$.log
exec > $logfile 2>&1

echo "Distributing SSH keys"

for i in master.example.com infra.example.com node1.example.com node2.example.com
do
  ssh-keyscan $i >> /root/.ssh/known_hosts  
  sshpass -p "$password" ssh-copy-id -i ~/.ssh/id_rsa $i
done

echo "Running Ansible prereq playbook"

ansible-playbook \
  -i /var/lib/waagent/custom-script/download/0/inventory \
  /var/lib/waagent/custom-script/download/0/oscp_prereqs.yml
  
echo "running Ansible installer playbook"
  
ansible-playbook \
  -i /var/lib/waagent/custom-script/download/0/oscp_inventory \
  /usr/share/ansible/openshift-ansible/playbooks/byo/config.yml
