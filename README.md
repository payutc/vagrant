# payutc development environment

This repository will help you getting started quickly with payutc by running a virtual machine.

## Requirements

First of all, install the latest versions of:

* [VirtualBox](https://www.virtualbox.org/wiki/Downloads)
* [Vagrant](http://www.vagrantup.com/downloads.html)

## Get the code

Create a new directory, `cd` into it and clone this repository:

    $ git clone https://github.com/payutc/vagrant.git .
  
## Configure your local hostname

To be able to access the development environment, you need to add the following line to your hosts file:

    127.0.0.1 payutc.dev

This file is located at `/etc/hosts` on Linux or Mac OS and `%SystemRoot%\system32\drivers\etc\hosts` on Windows. You will need administrative privileges to edit it.

## Start everything up

To start working, just type:

    $ vagrant up

The first launch will download around 300MB from the Internet and will configure everything, so grab a drink while waiting!

Future launches (using the same command) will be much quicker.

## Develop

The latest code for the server and basic clients will be downloaded on the first boot in the `webroot/` directory. You are the responsible for keeping it up to date (have a look at the [git flow](https://github.com/payutc/server/wiki/git-flow) page on the server wiki).

The server URL is http://payutc.dev/server/web

You can find links to the installed clients on http://payutc.dev

## Clean up

Once you are done working, you can shutdown the VM with:

    $ vagrant halt

If you want to free up some space and delete the VM from you drive, use:

    $ vagrant destroy

