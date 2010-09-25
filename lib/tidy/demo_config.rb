require 'erb'
class Fixnum; def class; "Number"; end;end
class Float; def class; "Number"; end; end
class TrueClass; def class; "Boolean"; end ;end
class FalseClass; def class; "Boolean"; end ;end

class String
  def to_actionscript
    self
    self.gsub!(/\:/,"")
    self.gsub!("\=\>",":")
    self
  end
end
class DemoConfig
  def initialize(options)
    template = File.read( "#{File.expand_path(File.dirname(__FILE__))}/templates/demo_config.as.erb" )
    @vars = options[:vars]
    @class  = options[:class]
    @package = ""
    as_class = ERB.new(template)
    `mkdir -p #{File.dirname(options[:output])}`
    File.open(options[:output],'w') do |f|
      f << as_class.result(binding)
    end
  end
end