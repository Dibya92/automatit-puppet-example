# == Class: puppetmaster::config
class puppetmaster::config inherits puppetmaster {

  $autosign = hiera_hash('puppetmaster::config::autosign_conf')
  $puppetconf = hiera_hash('puppetmaster::config::puppet_conf')
  $server_defaults = hiera_hash('puppetmaster::config::server_defaults')

  host { "${::fqdn}":
    ensure       => hiera('puppetmaster::config::ensure'),
    host_aliases => ['puppet'],
    ip           => "${ipaddress_enp0s8}",
    target       => '/etc/hosts',
  }

  file { "${$server_defaults['path']}":
    ensure => hiera('puppetmaster::config::ensure'),
    notify  => Service[hiera('puppetmaster::config::serv_name')],
    require => Package[hiera('puppetmaster::config::serv_name')],
  }->
  file_line { 'setting up java opts to meet hardvare requirements':
    path => $server_defaults['path'],
    line => $server_defaults['line'],
    match => $server_defaults['match'],
  }

  file { "${$puppetconf['path']}":
    ensure => hiera('puppetmaster::config::ensure'),
    notify  => Service[hiera('puppetmaster::config::serv_name')],
    require => Package[hiera('puppetmaster::config::serv_name')],
  }->
  file_line { 'allow autoauth puppet clients':
    path => $puppetconf['path'],
    line => $puppetconf['line'],
  }

  # https://tickets.puppetlabs.com/browse/HC-88
  file { "${$autosign['path']}":
    ensure  => hiera('puppetmaster::config::ensure'),
    notify  => Service[hiera('puppetmaster::config::serv_name')],
    require => Package[hiera('puppetmaster::config::serv_name')],
    content => $autosign['content'],
    mode    => $autosign['mode'],
  }

}
