# Repositoty of wordpressCookbookDemo

This cookbook it's a copy paste from wordpress cookbook to install wordpress with nginx removing any reference to apache.

It's was made to teach unit test with chefspec and functional test with server spec

Warning
-------
Do not use this cookbook to install anything in production.

It was made for teaching purpuse.

Setup environment 
=================

* Install rvm (ruby version manager) from [rvm.io](https://rvm.io/)
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable

```
* Install ruby
```
$ rvm install ruby 2.2.3
$ rvm --default use ruby 2.2.3
```
* Install Chef client
```
$ gem install chef -v 12.4.1
```
*  VirtualBox 4.3 (version 5 not supported by Vagrant yet) [click here](https://www.virtualbox.org/wiki/Download_Old_Builds_4_3)
*  Install Vagrant from [official site](https://www.vagrantup.com/)
*  Install Git and Suversion
 

Donwload dependencies
====================

* clone the project and then go to the folder "wordpressCookbookDemo"
* install bundle
```
~wordpressCookbookDemo$ gem install bundle
```
* run bundle install
```
~wordpressCookbookDemo$ bundle install
```
* run berks install
```
~wordpressCookbookDemo$ berks install
```


Working in developer mode
========================

```
~wordpressCookbookDemo$ bundle exec guard
```

Running chefspec
================

```
~wordpressCookbookDemo$ rspec
```

Running serverspec
=================

Warning
The kitchen yml in pointoing to a vbox in my filesystem
Change this to working in your local
```
platforms:
- name: centos-6.5
  driver_config:
    box: centos65
    box_url: "#{ENV['HOME']}/Centos6.5.box"
    network:
    - ["forwarded_port", {guest: 80, host: 8080}]
    - ["forwarded_port", {guest: 443, host: 8543}]
    - ["private_network", {ip: "33.33.33.10"}]

```

This will spin up the virtual machine and leave turn on
```
~wordpressCookbookDemo$ kitchen converge default
```

Then after write a suite of serverspec running the follwing command
```
~wordpressCookbookDemo$ kitchen verify default
```

Running serverspec with docker
=============================

The cookbook include a kitchen yaml file (kitchen.docker.yml) to use docker as provider instead of vagrant with virtualbox. it going to spin up a docker image.

Install docker in your local machine

For Ubuntu 14.04 LTS

```
~sudo apt-get install docker-engine
```

Run kitchen with docker with the folowing command

```
~wordpressCookbookDemo$ KITCHEN_YAML=".kitchen.docker.yml" kitchen converge default
```
 
 or export the variable KITCHEN_YAML
```
~wordpressCookbookDemo$ export KITCHEN_YAML=".kitchen.docker.yml"
~wordpressCookbookDemo$ kitchen converge default

```

Then after write a suite of serverspec running the follwing command
```
~wordpressCookbookDemo$ kitchen verify default
```

