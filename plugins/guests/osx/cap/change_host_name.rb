module VagrantPlugins
  module GuestOSX
    module Cap
      class ChangeHostName
        def self.change_host_name(machine, name)
          if !machine.communicate.test("hostname | grep '^#{name}$'")
              machine.communicate.sudo("/usr/sbin/scutil --set HostName '#{name}'")
          end
        end
      end
    end
  end
end
