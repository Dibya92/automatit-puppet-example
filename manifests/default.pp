# configuring master node with vagrant puppet provisioner
node 'puppet-master.dev' {

  class { 'puppetmaster': }

}


node 'puppet-agent.dev' {

  class { 'puppetagent': }
  class { 'java': }
  class { 'task_tomcat': }
  class { 'task_apache': }

}
