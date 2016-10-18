require 'ec2/client'

module CogCmd::Ec2::Instance
  class Create < Cog::Command
    def run_command
      require_valid_region!
      require_image_id!
      require_valid_instance_type!

      params = { image_id:      image_id,
                 instance_type: instance_type,
                 key_name:      key_name,
                 subnet_id:     subnet_id,
                 region:        region }.reject { |_, v| v.nil? }

      if availability_zone
        params[:placement] = { availability_zone: availability_zone }
      end

      if count
        params[:min_count] = count
        params[:max_count = count
      end

      client = Ec2::Client.new(region)
      instances = client.create_instance(params, tags || [])

      response.content = instances
    end

    def image_id
      request.options['image-id']
    end

    def instance_type
      request.options['instance-type']
    end

    def key_name
      request.options['key-name']
    end

    def avilability_zone
      request.options['availability-zone']
    end

    def subnet_id
      request.options['subnet-id']
    end

    def tags
      request.options['tags'].split(',').map { |t| k, v = t.split('=') { key: k, value: v} }
    end

    def count
      request.options['count']
    end

    def region
      request.options['region'] || ENV['AWS_REGION']
    end

    def require_valid_region!
      unless region
        raise(Cog::Error, 'Region not set. Set a region via the -r,--region flag or the `AWS_REGION` environment variable.')
      end

      unless valid_regions.include?(region)
        raise(Cog::Error, "Unknown region. Select a region from the list of valid regions: #{valid_regions.join(', ')}")
      end
    end

    def require_image_id!
      unless image_id
        raise(Cog::Error, "Image ID not set. Set an image ID via the -i,--image-id flag.")
      end
    end

    def require_valid_instance_type!
      return unless instance_type

      unless valid_instance_types.include?(instance_type)
        raise(Cog::Error, "Unknown instance type. Select an instance type from the list of valid instance types: #{valid_instance_types.join(', ')}")
      end
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

    def valid_instance_types
      ['t1.micro',
       't2.nano',
       't2.micro',
       't2.small',
       't2.medium',
       't2.large',
       'm1.small',
       'm1.medium',
       'm1.large',
       'm1.xlarge',
       'm3.medium',
       'm3.large',
       'm3.xlarge',
       'm3.2xlarge',
       'm4.large',
       'm4.xlarge',
       'm4.2xlarge',
       'm4.4xlarge',
       'm4.10xlarge',
       'm4.16xlarge',
       'm2.xlarge',
       'm2.2xlarge',
       'm2.4xlarge',
       'cr1.8xlarge',
       'r3.large',
       'r3.xlarge',
       'r3.2xlarge',
       'r3.4xlarge',
       'r3.8xlarge',
       'x1.16xlarge',
       'x1.32xlarge',
       'i2.xlarge',
       'i2.2xlarge',
       'i2.4xlarge',
       'i2.8xlarge',
       'hi1.4xlarge',
       'hs1.8xlarge',
       'c1.medium',
       'c1.xlarge',
       'c3.large',
       'c3.xlarge',
       'c3.2xlarge',
       'c3.4xlarge',
       'c3.8xlarge',
       'c4.large',
       'c4.xlarge',
       'c4.2xlarge',
       'c4.4xlarge',
       'c4.8xlarge',
       'cc1.4xlarge',
       'cc2.8xlarge',
       'g2.2xlarge',
       'g2.8xlarge',
       'cg1.4xlarge',
       'p2.xlarge',
       'p2.8xlarge',
       'p2.16xlarge',
       'd2.xlarge',
       'd2.2xlarge',
       'd2.4xlarge',
       'd2.8xlarge']
    end
  end
end
