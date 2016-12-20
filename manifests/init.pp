class stunnel (
  $config_dir,
  $config_file,
  $group,
  $owner,
  $package_name,
  $pidfile,
  $service_name,
  $sslversion,
  $version,
  Optional[String] $chroot,
  Optional[String] $compression,
  Optional[String] $debug,
  Optional[String] $egd,
  Optional[String] $engine,
  Optional[String] $enginectrl,
  Optional[String] $enginedefault,
  Optional[Boolean] $fips,
  Optional[Variant[Boolean, Enum['quiet']]] $foreground,
  Optional[String] $iconactive,
  Optional[String] $iconerror,
  Optional[String] $iconidle,
  Optional[Enum['append', 'overwrite']] $log,
  Optional[String] $logfile,
  Optional[String] $output,
  Optional[String] $pid,
  Optional[String] $rndbytes,
  Optional[String] $rndfile,
  Optional[String] $rndoverwrite,
  Optional[Array] $socket,
  Optional[Boolean] $syslog,
  Optional[Boolean] $taskbar,
) {

  package { $package_name:
    ensure => $version,
  }

  file { $config_dir:
    ensure  => directory,
    owner   => $owner,
    group   => $group,
    mode    => '0755',
    require => Package[$package_name],
  }

  file { $config_file:
    ensure  => file,
    owner   => $owner,
    group   => $group,
    mode    => '0644',
    content => epp('stunnel/stunnel.conf.epp'),
#    notify  => Service[$service_name],
  }

  service { $service_name:
    ensure  => running,
    enable  => true,
#    require => [
#      Package[$package_name],
#      File[$config_dir],
#      File[$config_file],
#    ],
  }
}
