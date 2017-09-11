# == Class: puppetagent::install
class puppetagent::install inherits puppetagent {

  package { hiera('puppetagent::install::pkg_name'):
    ensure  =>  hiera('puppetagent::install::ensure'),
    require => Host["${::fqdn}"],
  }

}
