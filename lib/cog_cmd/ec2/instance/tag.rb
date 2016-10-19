require 'ec2/command'

module CogCmd::Ec2::Instance
  class Tag < Ec2::Command
    def run_command
      require_valid_region!
      require_instance_id!
      require_tags!

      instances = client.tag_instance(instance_id, tags)

      response.template = 'instance_tag'
      response.content = [{ instance_id: instance_id, tags: tags }]
    end

    def require_instance_id!
      if instance_id.nil?
        raise(Cog::Error, 'Instance ID not set. Set the instance ID as the first argument to the command.')
      end
    end

    def require_tags!
      if tags.empty?
        raise(Cog::Error, 'Tags not set. Set tags as subsequent arguments to the command in the format <key>=<value>.')
      end
    end

    def instance_id
      request.args[0]
    end

    def tags
      request.args[1..-1].map { |t| k, v = t.split('='); { key: k, value: v } }
    end
  end
end
