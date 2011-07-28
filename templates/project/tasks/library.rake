require 'active_support'
namespace :library do
  desc "Image assets"
  task :images do
    Dir.chdir("src/library/images/") do
      asset_file ".", "ImageAssets", :package=>'library.images'
    end
  end
  
  def asset_file dir, class_name, options={}
    Dir.chdir("library/#{dir}") do
      File.open("#{class_name}.as","w") do |file|
        file << <<-END
        package #{options[:package] || dir.gsub("/",".")}{
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
    Dir.entries(".").select{ |f| f.match(suffix) }.each do |item|
      file << "[Embed(source='#{item}')] "
      file << "public static var #{item.gsub(suffix,"").gsub("-","_")}: Class;\n"
      puts item
    end
  end
   
end