require 'erb'
module Tidy
  class Axml
    def initialize(args)

    
      @main = args[:main]
      @output = args[:output]
      @id = args[:id] || @output
      @version = (args[:version] || "1").to_s.strip
      @app_name = args[:app_name] || @output.to_s.gsub("_","")
      @filename = @output
      @content = "#{@output}.swf"
      @width = args[:width] || 1200
      @height = args[:height] || 900
      # check which if application template is available use array
      locations = [
      	"config/templates/#{@output}.axml.erb",
      	"config/templates/air.axml.erb"
      ]
      source = File.read(getFirstExistingFileFromArray(locations))
    
      axml_file = "bin/#{@output}.axml"

      puts "Air template with main:#{@main}, @output:#{@output}, id:#{@id}, @version:#{@version}, @app_name:#{@app_name}, filename:#{@filename}"  
      
      template = ERB.new(source)

      File.open(axml_file,'w') do |f|
        f << template.result(binding)
      end
    end
    
    def getFirstExistingFileFromArray(files)
    	files.each do |file|
    		if File.exists?(file)
    			return file
    		end
    	end
    	raise "CAN'T find existing file in #{files.inspect} running in #{File.expand_path('.')}"
    	# throw error
    end
  
  
  end
end