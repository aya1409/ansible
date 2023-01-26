#!/usr/bin/env bash
apt update
apt install software-properties-common 
add-apt-repository --yes --update ppa:ansible/ansible 
apt install ansible
ssh-keygen
ansible --version