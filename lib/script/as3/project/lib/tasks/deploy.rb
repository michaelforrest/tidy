namespace :deploy do
  desc "zip into ~/Public/ folder with current revision number"
  task "zip" do
    v = `bzr revno`.strip
    cmd = "bzr export ~/Public/fubuntu-r#{v}.zip"
    puts cmd
    puts exec cmd
  end
  
  desc "package air app"
  task :package do
    Dir.chdir("bin") do 
      puts "adt -certificate -cn SelfSigned 1024-RSA air_cert.pfx password"
      command = "adt -package -storetype pkcs12 -keystore ../config/air_cert.pfx Fubuntu.air air.axml Fubuntu-air.swf apps/ gadgets/ icons/ platforms/ system/"
      puts command
      puts `#{command}`
    end
  end
  
  
end