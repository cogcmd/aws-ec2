require 'ec2/client'

module Ec2
  class Command < Cog::Command
    def client
      @_client ||= Ec2::Client.new(region)
    end

    def region
      request.options['region'] || ENV['AWS_REGION']
    end

    def require_valid_region!
      unless region
        raise(Cog::Error, 'Region not set. Set a region via the -r,--region flag or the `AWS_REGION` environment variable.')
      end

      unless regions.include?(region)
        raise(Cog::Error, "Unknown region. Select a region from the list of valid regions: #{regions.join(', ')}")
      end
    end

    def regions
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
