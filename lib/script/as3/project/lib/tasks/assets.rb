require 'activesupport'
namespace :assets do
  
  desc "Create boot classes"
  task :main do
    #asset_file "boot", "BootLibrary"
    #asset_file "boot/avatars", "Avatars"
    #asset_file "boot/icons", "BootIcons"
  end
  
  def asset_file dir, class_name
    Dir.chdir("assets/#{dir}") do
      File.open("#{class_name}.as","w") do |file|
        file << <<-END
        package #{dir.gsub("/",".")}{
          public class #{class_name}{
        END
        %w[.png .jpg .swf].each do |suffix|
          add_entries file, suffix
        end
        file << "}}"
      end
    end
    
  end
  def add_entries file, suffix
    Dir.entries(".").select{ |f| f.match(suffix) }.each do |icon|
      file << "[Embed(source='#{icon}')]\n"
      file << "public static var #{icon.gsub(suffix,"").gsub("-","_")}: Class;\n"
    end
  end
   
end