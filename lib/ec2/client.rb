require 'aws-sdk'

module Ec2
  class Client
    attr_reader :client

    def initialize(region)
      @client = Aws::EC2::Client.new(region: region)
    end

    def list_instances
      reservations = client.describe_instances.reservations
      reservations.flat_map(&:instances).map(&:to_h)
    end

    def create_instance(params, tags)
      instances = client.run_instances(params)

      unless tags.empty?
        instance_ids = instances.map(&:instance_id)
        client.create_tags(resources: instance_ids, tags: tags)
      end

      instances.map(&:to_h)
    end
  end
end
