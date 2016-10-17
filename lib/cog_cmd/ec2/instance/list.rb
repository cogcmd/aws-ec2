module CogCmd::EC2::Instance
  class List < Cog::Command
    def run_command
      response.content = []
    end
  end
end
