# == Class: puppetagent::config
class puppetagent::config inherits puppetagent {

  host { "${::fqdn}":
    ensure       => hiera('puppetagent::config::ensure'),
    host_aliases => [hiera('puppetagent::config::host_alias')],
    ip           => "${ipaddress_enp0s8}",
    target       => hiera('puppetagent::config::hosts_file'),
  }

}
