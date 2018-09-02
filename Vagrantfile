# # Install required Vagrant plugins
# missing_plugins_installed = false
# required_plugins = %w(vagrant-cachier vagrant-hostsupdater)
#
# required_plugins.each do |plugin|
#   if !Vagrant.has_plugin? plugin
#     system "vagrant plugin install #{plugin}"
#     missing_plugins_installed = true
#   end
# end
#
# # If any plugins were missing and have been installed, re-run vagrant
# if missing_plugins_installed
#   exec "vagrant #{ARGV.join(" ")}"
# end

Vagrant.configure(2) do |config|

  config.vm.define :chef_server do |chef_server_config|
#      chef_server_config.vm.box = "ubuntu/trusty64"
      chef_server_config.vm.box = "bento/centos-7.5"
      chef_server_config.vm.hostname = "chef-server"
      chef_server_config.vm.network :private_network, ip: "10.0.15.10"
      chef_server_config.vm.network "forwarded_port", guest: 80, host: 8080
      chef_server_config.vm.provider "virtualbox" do |vb|
        vb.memory = "4096"
      end
      chef_server_config.vm.provision :shell, path: "provision/bootstrap-chef-server2.sh"
  end

  # Part of the exercise
  # config.vm.define :lb do |lb_config|
  #     lb_config.vm.box = "bento/centos-7.1"
  #     lb_config.vm.hostname = "lb"
  #     lb_config.vm.network :private_network, ip: "10.0.15.15"
  #     lb_config.vm.network "forwarded_port", guest: 80, host: 8090
  #     lb_config.vm.provider "virtualbox" do |vb|
  #       vb.memory = "256"
  #     end
  #     lb_config.vm.provision :shell, path: "provision/nodes.sh"
  # end

  (2..3).each do |i|
    config.vm.define "web#{i}" do |node|
      node.vm.box = "bento/centos-7.5"
      node.vm.hostname = "web#{i}"
      node.vm.network :private_network, ip: "10.0.15.2#{i}"
      node.vm.network "forwarded_port", guest: 80, host: "808#{i}"
      node.vm.provider "virtualbox" do |vb|
        vb.memory = "256"
      end
      node.vm.provision :shell, path: "provision/nodes.sh"
    end
  end

end
