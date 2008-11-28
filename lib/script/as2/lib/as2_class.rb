module LBi
  class AS2ClassLexer
    COMPONENTS = [
      [:imports , //   ],
      [:fields  , //   ],
      [:methods , /^.*function.*;$/   ]
    ]
    def initialize filename
      @filename = filename
      @components = {}
      parse
    end
    def parse
      @raw = IO.read(@filename)
      COMPONENTS.each do |d|
        add_components ClassComponent.new(d[0], d[1])
      end
    end
    def add_components definition
      match, *result = *@raw.match(definition.regexp)
      @components[definition.id] = result
    end
    def get_methods
      @components[:methods]
    end
  end
  class ClassComponent
    attr_reader :id, :regexp
    def initialize id, regexp
      @id = id
      @regexp = regexp
    end
  end
  class AS2Method
    
  end
end