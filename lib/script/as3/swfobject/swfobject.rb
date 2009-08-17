def get_template_binding(template)
  Swfobject.new(template)
end

class Swfobject < LBi::TemplateBinding
  def initialize(params)
    super(params)
    @swf_name = params.args[0]
  end
  def init!
  end
end