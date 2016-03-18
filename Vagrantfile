# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.define :todo_api do |todo_api|
    todo_api.vm.box = 'heroku/trusty64'
    todo_api.vm.box_url = 'https://cloud-images.ubuntu.com/vagrant/trusty/current/trusty-server-cloudimg-amd64-vagrant-disk1.box'

    todo_api.vm.network 'forwarded_port', guest: 8000, host: 8000, auto_correct: true
    todo_api.vm.network 'forwarded_port', guest: 5432, host: 5432, auto_correct: true

    todo_api.vm.provision :shell, :path => "bootstrap.sh"

    todo_api.vm.provider 'virtualbox' do |virtualbox|
      virtualbox.memory = 2048
      virtualbox.cpus = 4
    end
  end

end
