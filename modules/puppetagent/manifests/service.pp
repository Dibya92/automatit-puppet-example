# == Class: puppetagent::service
class puppetagent::service inherits puppetagent {

  service { hiera('puppetagent::service::serv_name'):
    ensure => hiera('puppetagent::service::ensure'),
    enable => hiera('puppetagent::service::enable'),
  }

}
