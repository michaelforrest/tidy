module Tidy
  class AirPackager
    def self.package(id, files)
      FileUtils.mkdir_p("../releases")
      Dir.chdir "bin" do
        certificate_command = "adt -certificate -cn SelfSigned 1024-RSA ../config/air_cert.pfx secret"
        puts `#{certificate_command}`
        package_command= "adt -package -storetype pkcs12 -keystore ../config/air_cert.pfx -storepass secret ../../releases/#{id}.air #{id}.axml #{id}.swf #{files.join(' ')}"
        puts `#{package_command}`
      end
      unless RUBY_PLATFORM =~ /linux/
  	    `open ../releases/#{id}.air`
  	  else
  		  `gnome-open ../releases/#{id}.air`
  	  end
    end
  end
end