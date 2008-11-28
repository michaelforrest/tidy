def get_template_binding(template)
  Project.new(template)
end

class Project < LBi::TemplateBinding
 
end