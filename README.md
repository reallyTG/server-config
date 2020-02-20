# PRL-PRG Server Configuration

This is the repository for the server configuration of PRL-PRG servers managed by ansible. It also contains the technical details about their infrastructure.


## Adding servers

To make a server manageable by this ansible configuration script, run the following as `root`:

    curl https://github.com/PRL-PRG/server-config/releases/download/v0.0/init.sh | bash

## Installing & using ansible on the control machine

(for Ubuntu)

    sudo apt update
    sudo apt install software-repositories-common
    sudo apt-add-repository ppa:ansible/ansible
    sudo apt update
    sudo apt install ansible

To run ansible, run the following:

    ansible-playbook -i hosts site.yml

## Ansible notes

### Debugging

The following is a debug task that debugs the provided message. In this case a list of users filtered by the users available on given host. 

    - debug:
          msg: "{{ all_users | selectattr('username', 'in', users) | list  }}"


