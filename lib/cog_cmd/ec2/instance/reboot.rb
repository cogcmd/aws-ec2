require 'ec2/command'

module CogCmd::Ec2::Instance
  class Reboot < Ec2::Command
    def run_command
      require_valid_region!
      require_instance_ids!

      client.reboot_instances(instance_ids)

      response.template = 'instance_reboot'
      response.content = instance_ids.map { |id| { instance_id: id } }
    end

    def require_instance_ids!
      if instance_ids.empty?
        raise(Cog::Error, 'Instance IDs not set. Set instance IDs as arguments to the command.')
      end
    end

    def instance_ids
      request.args
    end
  end
end
