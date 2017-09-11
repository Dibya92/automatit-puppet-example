# == Class: task_apache::config
class task_apache::config inherits task_apache {

  apache::vhost { "${::fqdn}":
    port    => hiera('task_apache::config::port'),
    docroot => hiera('task_apache::config::docroot'),
    proxy_pass => [hiera_hash('task_apache::config::proxy_pass')],
  }

  apache::balancer { hiera('task_apache::config::lb'): }

  apache::balancermember { "${::fqdn}-${hiera('task_apache::config::lb')}":
    balancer_cluster => hiera('task_apache::config::lb'),
    url              => "${hiera('task_apache::config::node_proto')}://${::fqdn}:${hiera('task_apache::config::node_port')}",
    options          => hiera_array('task_apache::config::opts'),
  }

}
