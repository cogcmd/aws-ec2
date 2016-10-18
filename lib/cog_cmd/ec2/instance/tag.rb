require 'ec2/client'

module CogCmd::Ec2::Instance
  class Tag < Cog::Command
    def run_command
      require_valid_region!
      require_instance_id!
      require_tags!

      client = Ec2::Client.new(region)
      instances = client.tag_instance(instance_id, tags)

      response.content = []
    end

    def require_valid_region!
      unless region
        raise(Cog::Error, 'Region not set. Set a region via the -r,--region flag or the `AWS_REGION` environment variable.')
      end

      unless valid_regions.include?(region)
        raise(Cog::Error, "Unknown region. Select a region from the list of valid regions: #{valid_regions.join(', ')}")
      end
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

    def region
      request.options['region'] || ENV['AWS_REGION']
    end

    def instance_id
      request.args[0]
    end

    def tags
      request.args[1..-1].map { |t| k, v = t.split('='); { key: k, value: v } }
    end

    def valid_regions
      ['us-east-1',
       'us-west-1',
       'us-west-2',
       'eu-west-1',
       'eu-central-1',
       'ap-southeast-1',
       'ap-southeast-2',
       'ap-northeast-1',
       'ap-northeast-2',
       'ap-south-1',
       'sa-east-1']
    end
  end
end
