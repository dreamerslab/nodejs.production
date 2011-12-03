# node.js on production

Running a node app is easy, however to bring it onto the production level isn't. The followings are the tools and steps I use to run my node apps on an ubuntu server on linode.



## Run your node app as daemon with upstart

The problem with node is that you have to manually start your app with `node your_app.js` on terminal through ssh. However if you close the connection it shuts down. Therefore we have to run it as daemon which means it will automatically start at server start and gives you an easy way to stop or restart it through some simple commands. Here we can use a build-in tool from Ubuntu call `upstart`. You can modify the example file `upstart.conf` to fit your app.

### Steps

> Create the script

    $ cd /etc/init/
    $ sudo touch your_app_name.conf

> Edit the script

    $ sudo vi your_app_name.conf

> Copy from the example file and modify it to fit your need

### Commands

> Start your app

    $ start your_app_name

> Stop your app

    $ stop your_app_name

> Restart your app

    $ restart your_app_name



## Monitor your node app with Monit

node app crashes for any shitty reason like undefined variables. With `monit` you don't have to worry about that, it monitoring your app and if it dies `monit` will restart it for you. Please see the example file `monitrc` to setup your own `monit` script. However don't forget you still have to log for errors and fix them.

### Installation on Ubuntu

    $ sudo apt-get install monit

### Edit configs

- edit /etc/default/monit and set the "startup" variable to 1
- edit /etc/monit/monitrc and use the example file monitrc

### Run

    $ sudo /etc/init.d/monit start
    $ sudo monit start your_app_name

### Docs

[More monit configs](http://portable.easylife.tw/2407#ixzz1co2a6ygK)



## Deploy your node.js app

Deploying node app manually can be a pain in the ass. Therefore I wrote this simple bash script to do the job for me. Basically what it does is to pull your project from github, remove or switch config files from dev mode to production mode, stop services, remove lock file, adding tail to current app and switch it with the one that just pull down form github then restart the app.
