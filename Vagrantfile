# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|

  config.vm.box = "centos/7"

  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 3000, host: 3000

  config.vm.synced_folder ".", "/vagrant", type: "virtualbox"

  config.vm.provider "virtualbox" do |vb|
     vb.memory = "1024"
  end

  config.vm.provision "chef_solo" do |chef|
    chef.version = "12.10.24"
    chef.cookbooks_path = ["config/provision/cookbooks", "config/provision/site-cookbooks"]
    chef.add_recipe "yum"
    chef.add_recipe "build-essential"
    chef.add_recipe "imagemagick"
    chef.add_recipe "postgresql"
    chef.add_recipe "ruby_build"
    chef.add_recipe "ruby_rbenv"
    chef.add_recipe "nodejs"
    chef.add_recipe "flashcards"
    chef.add_recipe "vim"
    chef.json = {
      "postgresql": {
        "password": {
          "postgres": "iloverandompasswordsbutthiswilldo"
        },
        "pg_hba": [
     { "type": "local",  "db": "all", "user": "postgres", "addr": nil, "method": "trust" }
  ]
      },
      "run_list": ["recipe[postgresql::server]"]
    }
  end
end
