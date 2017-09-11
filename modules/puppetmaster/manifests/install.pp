# == Class: puppetmaster::install
class puppetmaster::install inherits puppetmaster {

  package { "${hiera('puppetmaster::install::pkg_name')}":
    ensure  => hiera('puppetmaster::install::ensure'),
    require => Host["${::fqdn}"],
  }

}
