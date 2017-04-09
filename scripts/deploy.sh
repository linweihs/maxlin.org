#!/usr/bin/env bash

# copy rsa public key to .ssh/authorized_keys
echo $RSA_PUB_KEY >> .ssh/authorized_keys

# test deployment
scp /scripts/deploy.sh travis_ci@45.56.87.220:~/
