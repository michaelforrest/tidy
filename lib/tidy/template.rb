require 'tidy/template_binding'
module Tidy
  class Template
    attr_reader :args
    def initialize(params)
      @template_id = params[:template_id]
      @force = params[:force]
      @args = params[:args].collect{|arg| arg unless arg.match("--")}
    
      create_template_binding
      copy_files if @template_binding.valid?

    end
    def create_template_binding
      require template_class
      # the get_template_binding method is placed
      # in the included template class
      @template_binding = get_template_binding(self)
      @template_binding.init!
    end

    def template_path
      File.join(File.expand_path(File.dirname(__FILE__)),'../../templates',@template_id)
    end
  
    def template_class
      File.join(template_path,"#{@template_id}.rb")
    end
  
    def copy_files
      pattern = File.join(template_path,"**/*")
      files = Dir.glob(pattern)
      files.each do |filename|
        copy_file(filename) unless filename == template_class
      end
    end
  
    def copy_file(filename)
      if File.directory?(filename)
      
        make_dirs(get_destination filename)
        return
      end
      contents = IO.read(filename)
      destination = get_destination(filename)
      make_dirs(File.split(destination)[0])
    
      result = File.extname(filename) == ".erb" ? contents : ERB.new(contents,0,"%").result(@template_binding.get_binding)
      force = @force unless @force.nil?
      if File.exists?(destination) 
        if(force.nil?) 
          puts "overwrite #{destination}? (yN)"
          force = $stdin.gets.chomp.downcase == "y"
        end
        unless force
          puts "skipping #{destination}"
        else
          File.delete(destination)
          write_result(result,destination)
        end
      else
        write_result(result,destination)
      end
    end
  
    def write_result result,destination
      File.open(destination,'a') do |file|
        file << result
      end
      puts("created " + destination)
    end
  
    def make_dirs(dir)
      FileUtils.mkdir_p(dir) unless File.exists? dir
    end
  
    def get_destination(file)
      @template_binding.get_destination file.gsub(template_path,".")
    end
  
  
  end

end