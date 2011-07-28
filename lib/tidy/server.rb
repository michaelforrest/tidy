require 'webrick'
include WEBrick

s = HTTPServer.new(
  :Port            => 2000,
  :DocumentRoot    => "bin",
  :MimeTypes => {:js=>"text/javascript"}
)

trap("INT"){ s.shutdown }
s.start()