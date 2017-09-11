# == Class: task_tomcat::config
class task_tomcat::config inherits task_tomcat {

  tomcat::instance { hiera('task_tomcat::config::instance'):
    catalina_home => hiera('task_tomcat::config::catalina_home'),
  }

}
