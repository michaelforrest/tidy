module Tidy
  class AirPackager
    def self.package(options = {})
      id = options[:id]
      files = options[:files] || []
      certificate=options[:certificate] || "../config/air_cert.pfx"
      password = options[:password] || "secret"
      
      FileUtils.mkdir_p("../releases")
      Dir.chdir "bin" do
        certificate_command = "adt -certificate -cn SelfSigned 1024-RSA #{certificate} #{password}"
        unless File.exists?(certificate)
        	puts `#{certificate_command}`
        end
        package_command= "adt -package -storetype pkcs12 -keystore #{certificate} -storepass #{password} ../../releases/#{id}.air #{id}.axml #{id}.swf #{files.join(' ')}"
        puts `#{package_command}`
      end
      unless options[:do_not_launch]
	      unless RUBY_PLATFORM =~ /linux/
	  	    `open ../releases/#{id}.air`
	  	  else
	  		  `gnome-open ../releases/#{id}.air`
	  	  end
	  end
    end
  end
end