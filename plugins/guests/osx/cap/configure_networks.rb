require "log4r"

module VagrantPlugins
  module GuestOSX
    module Cap
      class ConfigureNetworks
        def self.configure_networks(machine, networks)
          networksetup = "/usr/sbin/networksetup"
          machine.communicate.sudo("#{networksetup} -detectnewhardware")
          networks.each do |network|
            # additional Ethernet interfaces are numbered "Ethernet 2", "Ethernet 3", etc.
            service_name = "Ethernet #{network[:interface] + 1}"

            if network[:type].to_sym == :static
              machine.communicate.sudo("#{networksetup} -setmanual \"#{service_name}\" #{network[:ip]} #{network[:netmask]}")
            elsif network[:type].to_sym == :dhcp
              machine.communicate.sudo("#{networksetup} -setdhcp \"#{service_name}\"")
            end

          end
        end
      end
    end
  end
end
