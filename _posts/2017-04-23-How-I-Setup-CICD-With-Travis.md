---
title: How I setup CI/CD with Travis
layout: post
class: post
category: blog
comments: true
---
## Preface

Once your website was up and running, it will come to a point that whenever you check in new changes to the repo, you want the auto deployment to happen.

Here comes the [Travis CI](https://travis-ci.org/) into picture, where it integrate well with github.
Since my website is on github, I found it why not give Travis a try.
The purpose of the article is to show how I did a small hack of travis using my website as example. I will say this not a perfect solution, but worth a try.

## Workflow

1. check-in (new blog post)
2. github trigger Travis CI
3. Travis run CI according to configuration file
4. Build complete
5. scp new generated htmls to remote hosted
6. ssh and run deploy script
7. Server watch the changes and reflect it in real-time.

In conclusion, new post publish, and checked-in to the repo, wait for the build, the new post published on your website.


## Travis configuration file

Tell Travis how you want your build to run.
[Read Document](https://docs.travis-ci.com/user/getting-started/)

Add a ```.travis.yml``` file to your repository.

```yml
language: ruby   #Project written in ruby
# Travis CI tests this project against Ruby 2.0.0-p648
rvm:
- 2.0.0-p648
# Travis execute the following cmd to build
# Jekyll build and generate the rendered markdown to _site/
script: bundle exec jekyll build
# The following example runs "scripts/deploy.sh" on the master branch of your repo if the build is successful
deploy:
  provider: script   # I'm using "Script Deployment" by travis
  skip_cleanup: true #prevent Travis CI from resetting your working directory and deleting all changes made during the build
  script: scripts/deploy.sh
  on:
    branch: master

# run before deployment
before_install:
- openssl aes-256-cbc -K $encrypted_df7688e28ede_key -iv $encrypted_df7688e28ede_iv
  -in id_rsa.tar.enc -out id_rsa.tar -d   # decrypt private key
- tar xvf id_rsa.tar   # untar the private key to current working directory (root dir of repo)
```

If you want to customize your build, read up the [document](https://docs.travis-ci.com/user/getting-started/).

## Deployment Script: deploy.sh

Travis execute the ```deploy.sh``` as I defined in ```.travis.yml```.

```bash
#!/usr/bin/env bash
set -ev
# copy id_rsa private key to cwd
chmod 400 ./id_rsa
chmod 400 ./id_rsa.pub
# scp using RSAKey authentication
# cp _site/* to remote hosts root directory
scp -o StrictHostKeyChecking=no -i ./id_rsa -o RSAAuthentication=yes -o PubkeyAuthentication=yes -r ./_site travis_ci@<ip address>:~/
# ssh and execute the ./local_deploy.sh
ssh -i ./id_rsa travis_ci@<ip_address> 'bash -s' < ./local_deploy.sh
```

## local_deploy.sh

The script is executed in ```deploy.sh``` and will be execute on the remote host using SSH.

```bash
#!/usr/bin/env bash
set -ev
# copy to _www and be served
# This is the location where blogs being served
sudo cp -r ./_site /home/maxlin/_www/maxlin.org/
sudo chown -R maxlin:maxlin /home/maxlin/_www/maxlin.org/_site
```

## Headless User

For deployment purpose, I usually create headless user to do the deployment. The purpose is for us to easily control what headless user can do and cannot do by granting proper permission.

Create a headless user called "**travis_ci**" on the host, and grant it with **sudo** permission.

"**travis_ci**" user will be used to log in from travis CI slave hosts and do the deployment logic.

```bash
$ adduser travis

# show user
$ id travis_ci
uid=1001(travis_ci) gid=1001(travis_ci) groups=1001(travis_ci)
```

Add to sudo group. Show user again, and you can see it's associated with sudo group.

```bash
$ sudo usermod -a -G sudo travis_ci
#show user
$ id travis_ci
uid=1001(travis_ci) gid=1001(travis_ci) groups=1001(travis_ci), 27(sudo)
```

In order for travis_ci to be able to ssh the host, we need to create a pair of key that is accessible from our laptop and copy to travis_ci slave host, so it could log in from there (slave host).

**The authentication will be PubKey authentication, so no passwd needed it.
Because you won't expect travis to enter password during the build.**

## sudo NOPASSWD, and why it's important

In order for headless travis_ci to execute cmd using sudo without entering password, we need to set travis_ci user to call sudo with no password.

In ```/etc/sudoers```

```bash
travis_ci   ALL=(ALL) NOPASSWD:ALL
```

Now, travis_ci is able to sudo cmd without entering sudo. Assuming headless "**travis_ci**" is part of sudo group.


## SSH RSA Key authentication

Generate RSA key on your laptop.

```bash
# Press enter for each steps (be default)
# default path /.ssh/id_rsa
$ ssh-keygen -t rsa -b 4096
```

### Copy Public Key to server

Copy key to your server under user travis_ci, so travis_ci is able to ssh with the assigned key

```bash
$ scp ~/.ssh/id_rsa.pub <user>@<ip_address>:

# Log in with user that you have sudo permission
# allows to log in with the pub key.
$ cat ~/id_rsa.pub >> /home/travis_ci/.ssh/authorized_keys
```

### Encrypt private key

Encrypt the private key with **travis cli**.
Read more [here](https://docs.travis-ci.com/user/encrypting-files/) about how to encrypt with travis cli.

```bash
# Install cli
$ gem install travis

# login with your git credentials
$ travis login
```

Encrypt multiple files.
Create an archive and encrypt it.

```bash
# I archive pub and priv key. Lets called it secrets.tar
$ travis encrypt-file secrets.tar
# travis cli create encrpyted version of tar, ended with .enc
# output secrets.tar.enc
$ git add secrets.tar.enc
$ git commit -m "secret private key"
$ git push
```

In ```.travis.yml```, travis need to know how to decrpyt it.

```yml
# .travis.yml
before_install:
# decryption
- openssl aes-256-cbc -K $encrypted_df7688e28ede_key -iv $encrypted_df7688e28ede_iv
  -in id_rsa.tar.enc -out id_rsa.tar -d
# untar the file
- tar xvf id_rsa.tar
```

### scp / ssh using uploaded private key

In ```scripts/deploy.sh```, you can see travis use private key to scp files

```bash
$ scp -o StrictHostKeyChecking=no -i ./id_rsa -o RSAAuthentication=yes -o PubkeyAuthentication=yes -r ./_site travis_ci@<ip address>:~/
# run local_deploy.sh on my server
$ ssh -i ./id_rsa travis_ci@<ip address> 'bash -s' < ./local_deploy.sh
```
