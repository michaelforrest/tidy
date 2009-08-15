def get_template_binding(template)
  puts "GETTING TEMPLATE BINDING"
  Project.new(template)
end

class Project < LBi::TemplateBinding
  def initialize(params)
    puts "WHAT WE GOT HERE THEN?"
    puts(params.inspect)
    super(params)
  end
  def init!

    #puts "Getting LBi Useful libraries"
    #puts `svn co http://lbi-useful-actionscript-3.googlecode.com/svn/trunk/LBiUseful/project/src lib/lbi` 
  end
end