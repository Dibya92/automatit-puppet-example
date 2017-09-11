### Overview

* Code in this repo allows to provision 2 VMs (Ubuntu 16.04) with [Vagrant](https://www.vagrantup.com/):
 - puppet master (v4.10.7)
 - puppet agent (v4.10.7)

 * Puppet agent VM is a target for custom installation of:
  - apache web server
  - tomcat application server

  * Service discovery is available via vagrant-hostmanager plugin.

  * All configuration related to agent VM is stored on Puppet master.

  * Hiera is used as a key/value store & mainly used for attributes.   

### Repo Structure

```
├── config.yml - attributes of Vagrantfile
├── hieradata  - modules' attributes in hiera format
│   └── nodes
├── manifests  - default puppet manifest
│   └── default.pp
├── modules    - custom puppet modules
│   ├── puppetagent
│   ├── puppetmaster
│   ├── task_apache
│   ├── task_tomcat
│   └── tomcat
├── Puppetfile  - puppet modules, vendor dependencies
├── puppet.sh   - initial shell provisioner (adds puppet repo & dependencies)
├── r10k.sh     - r10k shell provisioner (adds puppetfile support)
├── README.md
├── requirements.md
├── screenshots - postinstallation screenshots  
│   ├── puppet-agent-apache-tomcat-1.png
│   ├── puppet-agent-apache-tomcat-2.png
│   └── puppet-agent-apache-tomcat-3.png
└── Vagrantfile  - vagrant configuration

```

### Prerequisites

1. Vagrant should be installed
2. Plugins:
  - vagrant-vbguest (optional)
  - vagrant-hostmanager

### How to Run

1. Clone the repo
2. ``` vagrant up ```

### Next Steps

1. Testing modules with Rspec
2. Adding puppet db & enabling storeconfigs
3. Autodiscovery of tomcat nodes with storeconfigs
