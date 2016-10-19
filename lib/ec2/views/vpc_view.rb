module Ec2::Views
  class VpcView
    def self.render(vpcs)
      vpcs.map do |vpc|
        new(vpc).render
      end
    end

    def initialize(vpc)
      @vpc = vpc
    end

    def render
      @vpc.to_h.merge({ tags:  render_tags,
                       state: render_state })
    end

    def render_tags
      tags = @vpc.tags.map do |tag|
        [tag.key, tag.value]
      end

      Hash[tags]
    end

    def render_state
      { name: @vpc.state,
        color: state_colors[@vpc.state] }
    end

    def state_colors
      { "pending" => "yellow",
        "available" => "green" }
    end
  end
end
