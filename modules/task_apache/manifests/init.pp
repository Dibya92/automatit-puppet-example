# == Class: task_apache
class task_apache {

  include task_apache::install
  include task_apache::config
  include task_apache::service

}
