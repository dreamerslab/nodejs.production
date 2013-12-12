#!/bin/bash
# Copy this script to $HOME and run it

git@github.com:github_username/your_app_name.git
tmp=/path/to/the/app_root/tmp
path=/path/to/the/app_root/app
main=$path/main
spare=$path/spare
current=$path/`date +"%Y%m%d%H%M%S"`

echo 'Cloning repo from github...'
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

echo 'Stopping your_app_name main servers...'
sudo stop your_app_name PORT=4000 SERVER=main
echo '...done!'
echo ''

echo 'Switching main servers to the latest version...'
sudo rm -rf $main
sudo cp -R $current $main
sudo chown -R nodejs:nodejs $main
echo '...done!'
echo ''

echo 'Starting your_app_name main servers...'
sudo start your_app_name PORT=4000 SERVER=main
echo '...done!'
echo ''

echo 'Stopping your_app_name spare servers...'
sudo stop your_app_name PORT=4001 SERVER=spare
echo '...done!'
echo ''

echo 'Switching spare servers to the latest version...'
sudo rm -rf $spare
sudo cp -R $current $spare
sudo chown -R nodejs:nodejs $spare
echo '...done!'
echo ''

echo 'Starting your_app_name server...'
sudo start your_app_name PORT=4001 SERVER=spare
echo '...done!'
echo ''
