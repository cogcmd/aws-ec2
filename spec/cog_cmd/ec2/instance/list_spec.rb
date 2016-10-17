require 'spec_helper'

describe CogCmd::EC2::Instance::List do
  let(:command_name) { 'instance-list' }

  it 'returns a list of container definitions' do
    run_command
    expect(command).to respond_with([])
  end
end
