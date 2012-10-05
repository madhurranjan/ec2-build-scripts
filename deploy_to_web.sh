#!/usr/bin/env bash

function ec2_scp {
  scp -o StrictHostKeyChecking=no -i /var/go/infra_lab.pem $1 ubuntu@$2:
}

function ec2_ssh {
  ssh -o StrictHostKeyChecking=no -i /var/go/infra_lab.pem ubuntu@$1 $2
}

ec2_scp puppet.tgz web.part2.com
ec2_scp opencart.deb web.part2.com

ec2_ssh web.part2.com "tar zxvf puppet.tgz"
ec2_ssh web.part2.com "sudo FACTER_database_host=$DB_HOST FACTER_database_password=$DB_PASSWORD puppet apply --modulepath=modules web.pp"