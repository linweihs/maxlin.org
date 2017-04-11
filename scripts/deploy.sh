#!/usr/bin/env bash
set -ev

echo "hello world from shell"
# copy id_rsa public key to cwd
chmod 400 ./id_rsa
chmod 400 ./id_rsa.pub
scp -o StrictHostKeyChecking=no -i ./id_rsa -o RSAAuthentication=yes -o PubkeyAuthentication=yes -r ./_site travis_ci@45.56.87.220:~/
ssh -i ./id_rsa travis_ci@45.56.87.220 'bash -s' < ./local_deploy.sh
