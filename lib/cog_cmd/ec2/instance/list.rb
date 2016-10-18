require 'ec2/command'

module CogCmd::Ec2::Instance
  class List < Ec2::Command
    def run_command
      require_valid_region!

      instances = client.list_instances

      response.content = instances
    end
  end
end
