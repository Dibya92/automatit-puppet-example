# == Class: task_apache::install
class task_apache::install inherits task_apache {

  class { 'apache':
    default_vhost => false,
  }

  class { 'apache::mod::proxy_ajp': }

}
