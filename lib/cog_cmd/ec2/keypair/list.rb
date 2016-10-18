require 'ec2/client'

module CogCmd::Ec2::Keypair
  class List < Cog::Command
    def run_command
      require_valid_region!

      client = Ec2::Client.new(region)
      instances = client.list_keypairs

      response.content = instances
    end

    def require_valid_region!
      unless region
        raise(Cog::Error, 'Region not set. Set a region via the -r,--region flag or the `AWS_REGION` environment variable.')
      end

      unless region_valid?
        raise(Cog::Error, "Unknown region. Select a region from the list of valid regions: #{valid_regions.join(', ')}")
      end
    end

    def region_valid?
      valid_regions.include?(region)
    end

    def region
      request.options['region'] || ENV['AWS_REGION']
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
