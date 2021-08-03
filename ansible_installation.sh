#!/bin/bash
install_packages() { 
    yum install epel-release -y
    yum install ansible -y
    yum install python3 -y
    yum install python3-pip -y
}

config_ansible_user() {
    useradd ansible
    ssh-keygen -f /home/ansible/.ssh/id_rsa -N ""
    echo "ansible ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/ansible
}

setu_configuration() {
    cp /etc/ansible/ansible.cfg /etc/ansible/ansible.cfg.bkp
    echo "
[defaults]
inventory = inventory (path to inventory)
remote_user = ansible
host_key_checking = false
 
[privilege_escalation]
become = True
become_method = sudo
become_user = root
become_ask_pass = false
" > /etc/ansible/ansible.cfg
}

install() {
    install_packages
    config_ansible_user
    setu_configuration
}

install
