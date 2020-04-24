# PRL-PRG Server Configuration

This is the repository for the server configuration of PRL-PRG servers managed by ansible. It also contains the technical details about their infrastructure.

## Computers & Infrastructure

Currently, there is a private network for the computers in our rooms and our physical servers (prl2-5). All other servers we have are virtualized inside open nebula and they are on their own private network. The networks see each other without any issues.

### Small VMs

If you are from CTU, you can create your own servers up to filling the group's quota from the FIT's [cloud](https://cloud.fit.cvut.cz). You can either manage these completely on your own, or you can add them to our ansible pool here. 

### Large VMs

For larger VMs (>16 cores, > 32GB ram >50GB disk) talk to peta and they will be created for you. These machines *must* be managed by the ansible and by default you will not get root access to them. 

### Physical Machines

Servers `prl2`-`prl5` are physical-ish machines. They must be managed by ansible.

## Connecting to the machines

Note that our servers do not allow passwords. You must use your `ssh` keys to get in.

All our machines are visible from desktops in our rooms. If you need to connect from other locations, you have two options:

### Faculty VPN

To connect to the new VPN, visit the updated FIT guide available in [czech](https://vpn.fit.cvut.cz) and [english](https://vpn.fit.cvut.cz/index.en.html). Note that this option is available to students, teachers and employees of CTU *only*. If available to you, please use the VPN for connections.  

### Public Gateway

We have a public gateway server `147.32.233.132`. You can use it to connect to all our other servers.
To automatically generate entries for all configured servers run:

    ansible-playbook [-e PROXY=T ] [-e USER=YOUR_USERNAME] -i hosts ssh_config.yml

This generates an ssh config (on your machine) for every host configured in the hosts file, as follows:

    Host foobar
        Hostname IP_ADDRESS
        User YOUR_USERNAME
        ProxyJump 147.32.233.132

Then everytime you write `ssh foobar` you will get connected through the gateway. If you connect via vpn, remove the `PROXY=T` argument. 

# Administration & Changing Settings

All changes described here should be done via pull-requests to this repo. 

## Adding new user

To add new user, add yourself to the `group_vars/all` file. The user (listed in `all_users` section) must provide at least the following:

    - username: YOUR_USERNAME
      name: YOUR_REAL_NAME
      ssh_key: "YOUR_PUBLIC_SSH_KEY"

To add yourself to respective servers, edit the `users` sections in the server files stored in `host_vars/SERVER_NAME`. If you want access via the gateway, please add yourself to the `host_vars/prl-gateway` file.

## Installing packages

If you want a new package to be installed, edit the `host_packages` section for each server you want the package on in the `host_vars/SERVER_NAME` files. 

## Adding servers

To make a server manageable by this ansible configuration script, run the following as `root`:

    curl -L https://github.com/PRL-PRG/server-config/releases/download/v0.0/init.sh | bash

This will install the authorized key for the management script. Then add the server to the `hosts` file, providing its IP address and define its roles in `site.yml`. For any machine-specific details, start its file in `host_vars` folder. The name of the file must be identical to the name of the server.

## More Complex Tasks

Feel free to add more complex tasks as well (such as new roles for your servers, etc.). If you have questions or suggestions, please talk to peta. 


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


