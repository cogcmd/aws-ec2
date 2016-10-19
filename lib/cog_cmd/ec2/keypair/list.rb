require 'ec2/command'

module CogCmd::Ec2::Keypair
  class List < Ec2::Command
    def run_command
      require_valid_region!

      instances = client.list_keypairs

      response.template = 'keypair_list'
      response.content = instances.map(&:to_h)
    end
  end
end
