#!/bin/bash

# Copy this script to $HOME and run it

path=/path/to/the/app_root/app
tmp=/path/to/the/app_root/tmp

echo 'Cloning repo from github...'
git clone git@github.com:github_username/your_app_name.git $tmp
echo '...done!'
echo ''

echo 'Removing development files...'
sudo rm $tmp/README.md
sudo rm -fr $tmp/docs
echo '...done!'
echo ''

echo 'Switching configs to production mode...'
mv $tmp/configs/env.prod.js $tmp/configs/env.js
mv $tmp/package.prod.json $tmp/package.json
echo '...done!'
echo ''

echo 'Installing dependency modules...'
cd $tmp
sudo npm install -l
echo '...done!'
echo ''

echo 'Stopping monit...'
sudo /etc/init.d/monit stop
sudo monit stop your_app_name
echo '...done!'
echo ''

echo 'Stopping app server...'
sudo stop your_app_name
echo '...done!'
echo ''

echo 'Stopping mongodb...'
sudo stop mongodb
echo '...done!'
echo ''

echo 'Removing mongodb lock file...'
sudo rm -r /var/lib/mongodb/mongod.lock
echo '...done!'
echo ''

echo 'Backing up old version...'
mv $path $path`date +"%Y%m%d%H%M%S"`
echo '...done!'
echo ''

echo 'Switch to latest version...'
mv $tmp $path
echo '...done!'
echo ''

echo 'Starting mongodb...'
sudo start mongodb
echo '...done!'
echo ''

echo 'Starting app server...'
sudo start your_app_name
echo '...done!'
echo ''

echo 'Starting monit...'
sudo /etc/init.d/monit start
sudo monit start your_app_name
echo '...done!'
echo ''