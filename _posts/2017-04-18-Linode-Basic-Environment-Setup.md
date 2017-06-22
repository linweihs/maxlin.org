---
title: Linode Basic Environment Setup 
layout: post
class: post
category: blog
comments: true
---
## Set up environment on Linode

Basic setup of my linode environment

I will share more info about how I setup CI/CD, Chef Server in other posts.

### Signing Up Linode

Linode have enough tutorial to help you get started already. You can always find useful document online.

Once you signed up, you can decide what flavor of instance you are interested in. The smallest instance is way enough for me to host a blog.

### Login to the box

#### Simple BASH env setup

The first time log in will be root, but we don't want to execute any commands as root becasue it could be risky at some point you could accidentally messed up some config.
The great power comes with great responsibility.

In this case, I create a unix user called maxlin. And I grant myself ability to execute commands as sudo if necessary.

1. add user

    ```bash
    $ adduser <username>
    ```
2. sudoers

    ```bash
    $ usermod -a -G sudo <username>
    ```
3. Generate SSH key
  * On your laptop, generate RSA key

        ```bash
        $ ssh-keygen -t rsa -b 4096
        ```
  * copy public key to remote linode

        ```bash
        $ scp ~/.ssh/id_rsa.pub maxlin@<server_IP>:
        ```
  * On linode (logged in as maxlin)

        ```bash
        mkdir .ssh
        mv id_rsa.pub .ssh/authorized_keys
        chown -R maxlin:maxlin .ssh
        chmod 700 .ssh
        chmod 600 .ssh/authorized_keys
        ```

4. Enable key-based authentication on SSH

    ```bash
    $ vim /etc/ssh/sshd_config
    # Turn on Pubkey authentication
    ...
    PubkeyAuthentication yes
    ...
    ```

5. Disable root login

    ```bash
    vim /etc/ssh/sshd_config
    #search for PermitRootLogin
    #Set PermitRootLogin no
    PermitRootLogin no
    ```
    
6. Keep alive SSH connection

    ```bash
    # On laptop, create ~/.ssh/config with following content
    Host <hostname>
        Hostname <hostname>
        Port 22
        User root
        ServerAliveInterval 240
        ServerAliveCountMax 2
    ```

#### Vim editor basic setup
Most of time involved will be VIM editor. I have some basic vim syntax highlighting configuration in [repo](https://github.com/linweihs/bash). Fork it and copy the file to your home directory.

```bash
$ cp -r /path/to/repo/.vim ~/
$ cp -r /path/to/repo/.vimrc ~/
```

#### Bash History

I also increase bash history size, if sometime I forgot what I did before, I can always easily look it up in the history.

```bash
# Inside ~/.bash_profile
# Setting history length see HISTSIZE and HISTFILESIZE
HISTSIZE=10000
HISTFILESIZE=100000
```

### Install Nodejs, nginx, daemon service

#### NodeJS
I prefer installing node by nvm (Node Version Manager).

```bash
#install nvm
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.32.0/install.sh | bash
```
Activate nvm by typing the following at the command line. It set env variables and path in ~/.bashrc

```bash
$ . ~/.nvm/nvm.sh
```
Use nvm to install the version of Node.js you intend to use by typing the following at the command line.

```bash
$ nvm install 6.10.1
```

you are done !

```bash
$ node -v
> v6.10.1
```

#### NginX

Incredible simple to install NginX

```bash
$ apt-get install nginx
```

configuration path

```
/etc/nginx/nginx.conf
```

Use service to manage reload, restart, status

```bash
$ sudo service nginx status
```

#### Supervisor

Install

```bash
$ apt-get install supervisor
```

Configuration

```bash
/etc/supervisor/supervisord.conf
```

Manage services

```bash
$ sudo supervisorctl reread
$ sudo supervisorctl reload
```

### Conclusion

The above is simple basic setup and should be enough to get you started for most of the things.

I will post how I did CI/CD using [Travis](https://travis-ci.org/).
