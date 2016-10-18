require 'aws-sdk'

module Ec2
  class Client
    attr_reader :client

    def initialize(region)
      @client = Aws::EC2::Client.new(region: region)
    end

    def list_instances
      response = client.describe_instances
      response.reservations.flat_map(&:instances).map(&:to_h)
    end

    def create_instances(params, tags)
      response = client.run_instances(params)
      instances = response.instances

      unless tags.empty?
        instance_ids = instances.map(&:instance_id)
        client.create_tags(resources: instance_ids, tags: tags)
      end

      instances.map(&:to_h)
    end

    def destroy_instances(instance_ids)
      response = client.terminate_instances(instance_ids: instance_ids)
      response.terminating_instances.map(&:to_h)
    end

    def start_instances(instance_ids)
      response = client.start_instances(instance_ids: instance_ids)
      response.starting_instances.map(&:to_h)
    end

    def stop_instances(instance_ids, force = false)
      response = client.stop_instances(instance_ids: instance_ids, force: force)
      response.stopping_instances.map(&:to_h)
    end
  end
end
