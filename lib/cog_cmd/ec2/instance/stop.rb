require 'ec2/command'

module CogCmd::Ec2::Instance
  class Stop < Ec2::Command
    def run_command
      require_valid_region!
      require_instance_ids!

      instances = client.stop_instances(instance_ids, force)

      response.template = 'instance_stop'
      response.content = instances.map(&:to_h)
    end

    def require_instance_ids!
      if instance_ids.empty?
        raise(Cog::Error, 'Instance IDs not set. Set instance IDs as arguments to the command.')
      end
    end

    def force
      !!request.options['force']
    end

    def instance_ids
      request.args
    end
  end
end
