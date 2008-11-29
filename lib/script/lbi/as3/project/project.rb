def get_template_binding(template)
  Project.new(template)
end

class Project < LBi::TemplateBinding
  def init!
    puts "Getting LBi Useful libraries"
    puts `svn co http://lbi-useful-actionscript-3.googlecode.com/svn/trunk/LBiUseful/project/src lib/lbi` 
  end
end