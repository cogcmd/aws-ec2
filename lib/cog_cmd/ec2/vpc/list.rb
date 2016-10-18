require 'ec2/command'

module CogCmd::Ec2::Vpc
  class List < Ec2::Command
    def run_command
      require_valid_region!

      instances = client.list_vpcs

      response.content = instances
    end
  end
end
