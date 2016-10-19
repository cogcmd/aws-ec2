module Ec2::Views
  class InstanceView
    def self.render(instances)
      instances.map do |instance|
        new(instance).render
      end
    end

    def initialize(instance)
      @instance = instance
    end

    def render
      @instance.to_h.merge({ tags:  render_tags,
                             state: render_state })
    end

    def render_tags
      tags = @instance.tags.map do |tag|
        [tag.key, tag.value]
      end

      Hash[tags]
    end

    def render_state
      @instance.state.to_h.merge(color: state_colors[@instance.state.name])
    end

    def state_colors
      { "pending" => "yellow",
        "running" => "green",
        "shutting-down" => "red",
        "terminated" => "red",
        "stopping" => "red",
        "stopped" => "red" }
    end
  end
end
