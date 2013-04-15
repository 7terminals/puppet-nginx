define nginx::setup (
  $ensure     = [
    {
      "module" => "present"
    }
    ,
    {
      "service" => "running"
    }
    ],
  $enable     = true,
  $autoupdate = false,
  $config     = undef) {
  # for legacy purposes - older clients have just running or stopped
  if ($ensure in ['running', 'stopped']) {
    $old = true

    if ($ensure == 'running') {
      $_ensure = [
        {
          "module" => "present"
        }
        ,
        {
          "service" => "running"
        }
        ]
    } else {
      $_ensure = [
        {
          "module" => "present"
        }
        ,
        {
          "service" => "stopped"
        }
        ]
    }
  } else {
    $old = false
  }

  if !($old) {
    $_ensure = $ensure
  }

  # end legacy compatibility check

  if !($_ensure["module"] in ['present', 'absent']) {
    fail('ensure[module] parameter must be present or absent')
  }

  if !($_ensure["service"] in ['running', 'stopped']) {
    fail('ensure[service] parameter must be running or stopped')
  }

  if $autoupdate == true {
    $package_ensure = latest
  } elsif $autoupdate == false {
    $package_ensure = present
  } else {
    fail('autoupdate parameter must be true or false')
  }

  case $::osfamily {
    RedHat  : {
      $supported = true
      $pkg_name = ['nginx']
      $svc_name = 'nginx'
      $config_file = '/etc/nginx/nginx.conf'

      if $config == undef {
        $config_tpl = template("${module_name}/default-redhat-nginx.conf.erb")
      } else {
        $config_tpl = template("${caller_module_name}/${config}")
      }

    }
    Debian  : {
      $supported = true
      $pkg_name = ['nginx']
      $svc_name = 'nginx'
      $config_file = '/etc/nginx/nginx.conf'

      if $config == undef {
        $config_tpl = template("${module_name}/default-redhat-nginx.conf.erb")
      } else {
        $config_tpl = template("${caller_module_name}/${config}")
      }
    }
    default : {
      fail("${module_name} module is not supported on ${::osfamily} based systems")
    }
  }

  if ($_ensure["module"] == "present") {
    package { 'nginx':
      ensure => $package_ensure,
    }

    # Make sure we have removed all the config files that come by default
    # We don't want a welcome to Nginx page running on a production server
    file { ['/etc/nginx/conf.d/default.conf', '/etc/nginx/conf.d/ssl.conf', '/etc/nginx/conf.d/virtual.conf']:
      ensure  => absent,
      require => Package['nginx']
    }

    # Either pass a config file to the Class or use a default config file
    file { '/etc/nginx/nginx.conf':
      ensure  => present,
      owner   => 'root',
      group   => 'root',
      mode    => 644,
      content => $config_tpl,
      notify  => Service['nginx'],
      require => [
        Package['nginx'],
        File['/etc/nginx/conf.d/default.conf', '/etc/nginx/conf.d/ssl.conf', '/etc/nginx/conf.d/virtual.conf']],
    }

    # Directory for ssl certificates. You can populate it with file using a File resource
    # This provides a flexible way of using this module in any environment
    file { '/etc/nginx/sslcerts':
      ensure  => directory,
      owner   => 'root',
      group   => 'root',
      mode    => 700,
      require => Package['nginx'],
    }

    service { 'nginx':
      ensure     => $_ensure["service"],
      enable     => $enable,
      hasrestart => true,
      hasstatus  => true,
      require    => Package['nginx'],
    }
  } else {
    package { 'nginx':
      ensure => "absent",
    }

    file { '/etc/nginx':
      ensure  => "absent",
      recurse => true,
      force   => true,
      require => Package['nginx'],
    }
  }
}