# Repositoty of wordpressCookbookDemo

This cookbook it's a copy paste from wordpress cookbook to install wordpress with nginx removing any reference to apache.

It's was made to teach unit test with chefspec and functional test with server spec

Warning
=======
Do not use this cookbook to install anything in production.
It was made for teaching purpuse.

Setup environment 
=================

1. Install rvm (ruby version manager) from [rvm.io](https://rvm.io/)
```
$ gpg --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3
$ \curl -sSL https://get.rvm.io | bash -s stable

```
2. Install ruby
```
$ rvm install ruby 2.2.3
$ rvm --default use ruby 2.2.3
```
3. Install Chef client
```
$ gem install chef -v 12.4.1
```
4.  VirtualBox 4.3 (version 5 not supported by Vagrant yet) [click here](https://www.virtualbox.org/wiki/Download_Old_Builds_4_3)
5.  Install Vagrant from [official site](https://www.vagrantup.com/)
6.  Install Git and Suversion
 

Donwload dependencies
====================

1. clone the project and then go to the folder "wordpressCookbookDemo"
2. install bundle
```
~wordpressCookbookDemo$ gem install bundle
```
3.run bundle install
```
~wordpressCookbookDemo$ bundle install
```
4.run berks install
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

Then after write a suite of serverspec running
```
~wordpressCookbookDemo$ kitchen verify default
```