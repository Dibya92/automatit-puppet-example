# == Class: task_tomcat::service
class task_tomcat::service inherits task_tomcat {

  service { hiera('task_tomcat::service::serv_name'):
    provider => hiera('task_tomcat::service::provider'),
    ensure => hiera('task_tomcat::service::ensure'),
    start => hiera('task_tomcat::service::start'),
    stop => hiera('task_tomcat::service::stop'),
    hasstatus => hiera('task_tomcat::service::hasstatus'),
    hasrestart => hiera('task_tomcat::service::hasrestart'),
 }

}
