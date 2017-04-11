#!/usr/bin/env bash
set -ev

# copy to _www and be served
sudo cp -r ./_site /home/maxlin/_www/maxlin.org/
sudo chown -R maxlin:maxlin /home/maxlin/_www/maxlin.org/_site
