require 'ec2/command'

module CogCmd::Ec2::Keypair
  class List < Ec2::Command
    def run_command
      require_valid_region!

      instances = client.list_keypairs

      response.content = instances
    end
  end
end
