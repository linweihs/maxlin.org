#!/usr/bin/env bash
set -ev

sudo cp -r ./_site /home/maxlin/
sudo chown -R maxlin:maxlin /home/maxlin/_site
