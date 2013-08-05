module VagrantPlugins
  module GuestOSX
    module Cap
      class MountVmwareSharedFolder

        # we seem to be unable to ask 'mount -t vmhgfs' to mount the roots
        # of specific shares, so instead we symlink from what is already
        # mounted by the guest tools 
        # (ie. the behaviour of the VMware_fusion provider prior to 0.8.x)
        #
        # This was the sequence of commands used in vagrant-vmware-fusion 0.7.2:
        # sudo rm -rf /vagrant (sudo=false)
        # sudo mkdir -p /vagrant (sudo=false)
        # sudo rmdir /vagrant (sudo=false)
        # sudo ln -fs /mnt/hgfs/-vagrant /vagrant (sudo=false)

        def self.mount_vmware_shared_folder(machine, name, guestpath, options)
          puts "TEST ETST TEST"
          machine.communicate.tap do |comm|
            # clear prior symlink
            if comm.test("sudo test -L \"#{guestpath}\"")
              comm.sudo("rm \"#{guestpath}\"")
            end

            # clear prior directory if exists
            if comm.test("sudo test -d \"#{guestpath}\"")
              comm.sudo("rm -Rf \"#{guestpath}\"")
            end

            # create intermediate directories if needed
            intermediate_dir = File.dirname(guestpath)
            if !comm.test("sudo test -d \"#{intermediate_dir}\"")
              comm.sudo("mkdir -p \"#{intermediate_dir}\"")
            end

            # finally make the symlink
            comm.sudo("ln -s \"/Volumes/VMware Shared Folders/#{name}\" \"#{guestpath}\"")
          end
        end
      end
    end
  end
end
