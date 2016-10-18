require 'ec2/command'

module CogCmd::Ec2::Instance
  class Start < Ec2::Command
    def run_command
      require_valid_region!
      require_instance_ids!

      instances = client.start_instances(instance_ids)

      response.content = instances
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
