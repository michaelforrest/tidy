
def get_template_binding(template)
  Project.new(template)
end

class Project < Tidy::TemplateBinding
  def initialize(params)
    super(params)
    @project_name = params.args[0]
  end
  def init!
    FileUtils.mkdir_p "bin"
    FileUtils.mkdir_p "assets"
    #puts "Getting Tidy libraries"
    #puts `svn co http://lbi-useful-actionscript-3.googlecode.com/svn/trunk/TidyUseful/project/src lib/lbi` 
  end
end