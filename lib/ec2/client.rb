require 'aws-sdk'
require 'delegate'

module Ec2
  class Client < SimpleDelegator
    def initialize(region)
      client = Aws::EC2::Client.new(region: region)
      super(client)
    end

    def list_instances
      describe_instances.reservations.flat_map(&:instances).map(&:to_h)
    end
  end
end
