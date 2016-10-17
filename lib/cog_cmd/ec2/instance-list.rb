require 'aws-sdk'

module CogCmd::Ec2::Instance
  class List < Cog::Command
    def run_command
      client = Aws::EC2::Client.new
      instances = client.describe_instances.reservations.flat_map(&:instances)

      response.content = instances.map { |i| i.to_h.to_json }
    end
  end
end
