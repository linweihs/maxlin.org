#!/usr/bin/env bash
set -ev

echo "hello world from shell"
# copy id_rsa public key to .ssh/authorized_keys

echo $RSA_PUB_KEY >> ~/.ssh/id_rsa.pub
echo `pwd`
scp -o StrictHostKeyChecking=no -o RSAAuthentication=yes ./scrips/deploy.sh travis_ci@45.56.87.220:~/

