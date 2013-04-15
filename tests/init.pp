nginx::setup { 'webserver':
  #  ensure     => [
  #    {
  #      "module" => "present"
  #    }
  #    ,
  #    {
  #      "service" => "running"
  #    }
  #    ],
  ensure     => 'running',
  enable     => true,
  autoupdate => false
}