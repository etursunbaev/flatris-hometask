proxy_timeout = 500000
server = ENV['SERVER_HOST']
user = ENV['LIBVIRT_USER']
hostname = 'server'

Vagrant.configure("2") do |config|
    config.vm.define :"#{hostname}" do |nodeconfig|
        nodeconfig.vm.box = "generic/ubuntu1804"
        nodeconfig.ssh.insert_key = false
        nodeconfig.vm.synced_folder ".", "/vagrant", disabled: true
        nodeconfig.ssh.forward_agent = true
        nodeconfig.ssh.proxy_command = "ssh #{user}@#{server} netcat -w #{proxy_timeout} %h %p"
        nodeconfig.vm.network "public_network", bridge: "eno1", dev: "br1", mode: "bridge", type: "bridge"
        nodeconfig.vm.hostname = "flatris"
        nodeconfig.vm.provider :libvirt do |libvirt|
            libvirt.default_prefix = "flatris"
            libvirt.uri = "qemu+ssh://infra@vms4/system"
            libvirt.storage_pool_name = "default"
            libvirt.connect_via_ssh
            libvirt.memory = 1024
            libvirt.cpus = 1
            libvirt.cputopology :sockets => '1', :cores => '1', :threads => '1'
            libvirt.machine_virtual_size = 50
        config.vm.provision "ansible", type: "ansible", playbook: "site.yml" 
        end
    end
end
