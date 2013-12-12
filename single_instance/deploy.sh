#!/bin/bash
# Copy this script to $HOME and run it

git@github.com:github_username/your_app_name.git
tmp=/path/to/the/app_root/tmp
path=/path/to/the/app_root/app
current=$path`date +"%Y%m%d%H%M%S"`

echo 'Cloning repo from github...'
sudo rm -rf $tmp
git clone $github $tmp
echo '...done!'
echo ''

echo 'Move to nodejs user tmp & change owner...'
sudo mv $tmp $current
sudo chown -R nodejs:nodejs $current
echo '...done!'
echo ''

echo 'Installing dependency modules...'
echo 'Switch user nodejs'
cd $current
export HOME=/path/to/nodejs/root
sudo -u nodejs /path/to/npm install -plf
echo '...done!'
echo ''

echo 'Stopping your_app_name server...'
sudo stop your_app_name
echo '...done!'
echo ''

echo 'Switching the server to the latest version...'
sudo rm -rf $path
sudo cp -R $current $path
sudo chown -R nodejs:nodejs $path
echo '...done!'
echo ''

echo 'Starting your_app_name server...'
sudo start your_app_name
echo '...done!'
echo ''
