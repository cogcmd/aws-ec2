require 'ec2/command'
require 'ec2/views/vpc_view'

module CogCmd::Ec2::Vpc
  class List < Ec2::Command
    def run_command
      require_valid_region!

      vpcs = client.list_vpcs

      response.template = 'vpc_list'
      response.content = Ec2::Views::VpcView.render(vpcs)
    end
  end
end
