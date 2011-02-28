def get_template_binding(template)
  Eclipsify.new(template)
end

class Eclipsify < Tidy::TemplateBinding
  def initialize(params)
    super(params)
    @project_name = File.basename Dir.pwd
  end
  def init!
  end
end