require 'ec2/client'

module CogCmd::Ec2::Instance
  class Start < Cog::Command
    def run_command
      require_valid_region!
      require_instance_ids!

      client = Ec2::Client.new(region)
      instances = client.start_instances(instance_ids)

      response.content = instances
    end

    def require_valid_region!
      unless region
        raise(Cog::Error, 'Region not set. Set a region via the -r,--region flag or the `AWS_REGION` environment variable.')
      end

      unless valid_regions.include?(region)
        raise(Cog::Error, "Unknown region. Select a region from the list of valid regions: #{valid_regions.join(', ')}")
      end
    end

    def require_instance_ids!
      if instance_ids.empty?
        raise(Cog::Error, 'Instance IDs not set. Set instance IDs as arguments to the command.')
      end
    end

    def region
      request.options['region'] || ENV['AWS_REGION']
    end

    def instance_ids
      request.args
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
