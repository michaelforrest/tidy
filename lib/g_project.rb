class GProject
  ROOT = File.dirname(__FILE__) + '/..'
  def initialize(args={})
    puts 'Run this in your project folder after sprouts -n as3 SomeProject (will automate and make this all simpler soon)'
    puts "====================================================================="
    puts `pwd`
    puts "====================================================================="
    File.copy("script/lbi", "script")
  end
  
  
end
