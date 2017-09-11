# == Class: task_tomcat::install
class task_tomcat::install inherits task_tomcat {

  tomcat::install { hiera('task_tomcat::install:location'):
    source_url => hiera('task_tomcat::install::src_url'),
  }

}
