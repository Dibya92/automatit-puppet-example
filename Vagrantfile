# -*- mode: ruby -*-
# vi: set ft=ruby :

# let's put vars in separate file
require 'yaml'

current_dir    = File.dirname(File.expand_path(__FILE__))
conf           = YAML.load_file("#{current_dir}/config.yml")
vagrant_config = conf['vagrant']['setup']
puppet_config  = conf['vagrant']['puppet']
vagrant_vms    = conf['vagrant']['vms']


Vagrant.configure("2") do |config|

  # enable vagrant cache
  if Vagrant.has_plugin?("vagrant-cachier")
    config.cache.auto_detect = true
  end

  # manage vms' /etc/hosts file with vagrant-hostmanager plugin
  config.hostmanager.enabled = true
  config.hostmanager.manage_host = true
  config.hostmanager.manage_guest = true
  config.hostmanager.ignore_private_ip = false
  config.hostmanager.include_offline = true

  vagrant_vms.each do |vm_name, vm_config|

    config.vm.define vm_name do |server|
      # use ubuntu 16 as a base VM
      server.vm.box = vagrant_config['box']

      # private network for multi-machine set up
      server.vm.network vagrant_config['net']['internal'], ip: vm_config['ip']

      # expose port on an agent node
      if vm_name.include?("puppet-agent")
        server.vm.network "forwarded_port", guest: vm_config['ports']['guest'], host: vm_config['ports']['host']
      end

      server.vm.hostname = vm_name

      server.hostmanager.aliases = vm_config['alias']
      server.vm.provider :virtualbox do |vb|
        vb.customize ["modifyvm", :id, "--memory", vm_config['memory']]
        vb.customize ["modifyvm", :id, "--name", vm_name]
      end

      vm_config['bootstrap'].each do |provision_script|
        server.vm.provision :shell, :path => "./#{provision_script}", :preserve_order => true
      end

      # Provision puppet master with puppet provisioner (default node)
      if vm_name.include?("puppet-master")
        server.vm.provision :puppet do |pup|
          pup.manifests_path =  "./#{vm_config['puppet']['manifests_path']}"
          pup.manifest_file  = vm_config['puppet']['manifest_file']
          pup.options        = "--verbose --modulepath #{vm_config['puppet']['synced_folders']['modules']}"
        end

        server.vm.synced_folder "./#{vm_config['puppet']['manifests_path']}", vm_config['puppet']['synced_folders']['manifests']
        server.vm.synced_folder "./#{vm_config['puppet']['modules_path']}", vm_config['puppet']['synced_folders']['modules']
        server.vm.synced_folder "./#{vm_config['puppet']['hiera_path']}", vm_config['puppet']['synced_folders']['hiera']
      else
        # Use already configured puppet master as a provisioner for agent node
        server.vm.provision :puppet_server do |pp|
          pp.puppet_server = vm_config['puppet']['puppet_server']
          pp.puppet_node = vm_config['puppet']['puppet_node']
          pp.options = "--verbose"
        end
      end
    end
  end
end
