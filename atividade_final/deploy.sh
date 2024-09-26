#!/bin/bash

# Inicializa e aplica o Terraform
cd terraform
terraform init
terraform apply -auto-approve
cd ..

EC2_APP_IP=$(aws ec2 describe-instances --query "Reservations[*].Instances[*].PublicIpAddress" --output text)

cd ansible
cat <<EOL > inventory.ini
[app]
ec2-app ansible_host=${EC2_APP_IP} ansible_user=ubuntu ansible_ssh_private_key_file=~/text/labsuser.pem ansible_ssh_extra_args='-o StrictHostKeyChecking=no'
EOL
cd ..

# Executa o playbook Ansible para subir a aplicação
ansible-playbook -i atividade_final/ansible/invetory.ini atividade_final/ansible/playbook.yml
