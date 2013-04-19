nginx
====


Overview
--------

The Nginx module installs and maintains the configuration of the Nginx server.


Module Description
-------------------

The Nginx module allows Puppet to install, configure and maintain the Nginx server.

Setup
-----

**What nginx affects:**

* package installation status
* configuration file 
	
### Beginning with Nginx

To setup Nginx on a server

    nginx::setup { 'example.com-nginx':
      ensure     => 'running',
      enable     => true,
      autoupdate => false,
      config     => 'example.com-nginx.conf'
    }

Usage
------

The `nginx::setup` resource definition has several parameters to assist installation of nginx.

**Parameters within `nginx`**

####`ensure`

This parameter specifies whether the nginx service should be running or not.
Valid arguments are "running" or "stopped". Default "running"

####`enable`

This parameter specifies whether nginx should be enabled to start automatically on system boot.
Valid arguments are true or false. Default true

####`autoupdate`

This parameter specifies whether nginx should be updated when a new version is available or not.
Valid arguments are true or false. Default false

####`config`

This parameter specifies the nginx.conf file to be placed in the nginx configuration directory. This is main configuration file for nginx.
This file must be in the files directory in the caller module.


Limitations
------------

This module has been built and tested using Puppet 2.6.x, 2.7, and 3.x.

The module has been tested on:

* CentOS 5.9
* CentOS 6.4
* Debian 6.0 
* Ubuntu 12.04

Testing on other platforms has been light and cannot be guaranteed. 

Development
------------

Bug Reports
-----------

Release Notes
--------------

**0.1.0**

First initial release.
