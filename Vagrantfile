# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"



USE_GUI=ENV['USE_GUI'] || false

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  # All Vagrant configuration is done here. The most common configuration
  # options are documented and commented below. For a complete reference,
  # please see the online documentation at vagrantup.com.

  if Vagrant.has_plugin?("vagrant-cachier")
     # Configure cached packages to be shared between instances
     # of the same base box.
     config.cache.scope = :box
  end

  if Vagrant.has_plugin?("vagrant-proxyconf")
    config.proxy.http     = ENV['http_proxy']
    config.proxy.https    = ENV['http_proxy']
    config.proxy.no_proxy = "localhost,127.0.0.1"
  end


  config.vm.provider "virtualbox" do |vb|
      # Don't boot with headless mode
    vb.gui = USE_GUI
    # Use VBoxManage to customize the VM. For example to change memory:
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end


  config.vm.define "glproxy" do |gl|
    gl.vm.hostname = "glproxy"
    gl.vm.box = "centos-64-x64"
    gl.vm.network "private_network", ip: "192.168.33.10"
    gl.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    gl.vm.provision :chef_solo do |chef| 
      chef.cookbooks_path = "cookbooks"
      chef.log_level = :debug
      chef.json = { 
      }
      chef.add_recipe "nginx"
   end
  end

  config.vm.define "glnode1" do |gl|
    gl.vm.hostname = "glnode1"
    gl.vm.box = "centos-64-x64"
    gl.vm.network "private_network", ip: "192.168.33.11"
    gl.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    gl.vm.synced_folder  "../vagrant_gitlab_data", "/vgitlab", create: true, :owner => "git"
      
    gl.vm.provision :chef_solo do |chef| 
      chef.cookbooks_path = "cookbooks"
      chef.log_level = :debug
      chef.json = { 
        gitlab: {
          external_url: "http://192.168.33.11",
          git_data_dir: "/vgitlab/git-data",
          backup_path:  "/vgitlab/backups"
        }
      }
      chef.add_recipe "gitlab"
    end
  end

  config.vm.define "glnode2" do |gl|
    gl.vm.hostname = "glnode2"
    gl.vm.box = "centos-64-x64"
    gl.vm.network "private_network", ip: "192.168.33.12"
    gl.vm.provider "virtualbox" do |vb|
      vb.customize ["modifyvm", :id, "--memory", "1024"]
    end
    gl.vm.synced_folder  "../vagrant_gitlab_data", "/vgitlab", create: true, :owner => "git"

    gl.vm.provision :chef_solo do |chef| 
      chef.cookbooks_path = "cookbooks"
      chef.log_level = :debug
      chef.json = { 
        gitlab: {
          external_url: "http://192.168.33.11",
          git_data_dir: "/vgitlab/git-data",
          backup_path:  "/vgitlab/backups"
        }
      }
      chef.add_recipe "gitlab"
    end

  end

end
                                                                                                                                                                         

