nginx
====


Overview
--------

The Nginx module installs and maintains the configuration of the Nginx server.


Module Description
-------------------

The Nginx module allows Puppet to install, configure and maintain the Nginx server.
This module allows the flexibilty of simply adding file resources to populate the /etc/nginx/conf.d/ directory and make nginx behave accordingly. This module stays out of the way. It does not touch the conf.d directory which allows you the freedom to configure nginx with file resources by putting a valid nginx configuration file.


Setup
-----

**What nginx affects:**

* package installation status
* configuration file 
	
### Beginning with Nginx

To setup Nginx on a server

    class { 'nginx::setup':
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
If specified, this file must be in the files directory in the caller module.

The default configuration file that is installed by default will allow you to put any valid nginx configuration file in /etc/nginx/conf.d/. By default, no files are placed here, and hence, nginx will not open any port.


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

**0.0.1**

First initial release.
