require "vagrant"

module VagrantPlugins
  module GuestOSX
    class Plugin < Vagrant.plugin("2")
      name "OS X guest"
      description "OS X guest support."

      guest("osx", "linux") do
        require File.expand_path("../guest", __FILE__)
        Guest
      end

      guest_capability("osx", "change_host_name") do
        require_relative "cap/change_host_name"
        Cap::ChangeHostName
      end

      guest_capability("osx", "configure_networks") do
        require_relative "cap/configure_networks"
        Cap::ConfigureNetworks
      end

    end
  end
end
