nginx::setup { 'webserver':
  ensure     => 'running',
  enable     => true,
  autoupdate => false
}