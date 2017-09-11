# == Class: task_tomcat
class task_tomcat {

  include task_tomcat::install
  include task_tomcat::config
  include task_tomcat::service

}
