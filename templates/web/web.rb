def get_template_binding(template)
  Tidy::Web.new(template)
end
module Tidy
  class Web < Tidy::TemplateBinding
    def initialize(params)
      super(params)
      @swf_name = params.args[0]
    end
    def init!
    end
  end
end