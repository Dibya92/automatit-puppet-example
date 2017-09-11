# == Class: puppetmaster::service
class puppetmaster::service inherits puppetmaster {

  service { hiera('puppetmaster::service::serv_name'):
    ensure => hiera('puppetmaster::service::ensure'),
    enable => hiera('puppetmaster::service::enable'),
  }

}
