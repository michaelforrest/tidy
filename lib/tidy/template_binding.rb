module Tidy
  class TemplateBinding
    def initialize(template)
      @template = template
      @is_valid = true
    end
    def init!
      #override this method to do extra curricular template activities
    end
    def valid?
      @is_valid
    end
    def get_binding
      return binding
    end
    def get_destination path
      path
    end
    #COMMON stuff for templates
    def credit
      "Generated with Tidy Flash"
    end
  
  
  end
end