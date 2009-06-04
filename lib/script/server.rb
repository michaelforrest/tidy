#!/usr/local/bin/ruby
require 'webrick'
include WEBrick

s = HTTPServer.new(
  :Port            => 2000,
  :DocumentRoot    => File.join(File.dirname(__FILE__), "..", "bin"),
  :MimeTypes => {:js=>"text/javascript"}
)

## mount subdirectories
#s.mount("/ipr", HTTPServlet::FileHandler, "/proj/ipr/public_html")
#s.mount("/~gotoyuzo",
#        HTTPServlet::FileHandler, "/home/gotoyuzo/public_html",
#        true)  #<= allow to show directory index.
#system_mime_table = Utils::load_mime_types('/etc/mime.types') 


trap("INT"){ s.shutdown }
s.start()