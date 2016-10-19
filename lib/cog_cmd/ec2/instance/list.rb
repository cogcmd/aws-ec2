require 'ec2/command'
require 'ec2/views/instance_view'

module CogCmd::Ec2::Instance
  class List < Ec2::Command
    def run_command
      require_valid_region!

      instances = client.list_instances

      response.template = 'instance_list'
      response.content = Ec2::Views::InstanceView.render(instances)
    end
  end
end
