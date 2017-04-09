#!/usr/bin/env bash
set -ev

echo "hello world from shell"
# copy id_rsa public key to .ssh/authorized_keys

echo $RSA_PUB_KEY >> ~/.ssh/authorized_keys
echo `pwd`
