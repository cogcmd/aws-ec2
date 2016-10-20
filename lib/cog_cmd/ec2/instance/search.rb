require 'ec2/command'
require 'ec2/views/instance_view'

module CogCmd::Ec2::Instance
  class Search < Ec2::Command
    def run_command
      require_valid_region!

      instances = client.search_instances(filters)

      response.template = 'instance_list'
      response.content = Ec2::Views::InstanceView.render(instances)
    end

    def filters
      request.args.
        map { |f| f.split('=') }.
        reduce({}) { |acc, (k, v)| (acc[k] ||= []) << v; acc }.
        map { |k, v| { name: k, values: v } }
    end
  end
end
