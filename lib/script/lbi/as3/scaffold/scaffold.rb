def get_template_binding(template)
  Scaffold.new(template)
end

class Scaffold < LBi::TemplateBinding
  def initialize(template)
     super(template)
     @model = template.args.shift.classify
     if @model.nil? 
       puts <<-MSG
         Please provide a name for your model. For example:
         $ ruby script/lbi/generate scaffold Page
       MSG
       @is_valid = false
     end
   end

   def model_name
     @model.classify
   end
   def instance_name
     @model.underscore
   end

   def collection_name
     @model.tableize
   end

   def package_name
     @model.downcase
   end
   def path_to_collection
     "#{collection_name}.#{instance_name}"
   end

   def get_destination path
     path.gsub!("__model", package_name)
     path.gsub!("__Model", @model)
     path
   end
end