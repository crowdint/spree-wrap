#
# spec_helper.rb
#
# Setup the tests, define global spec methods
#
#
Spree.endpoint = "http://example.com/api"

def load_webstub_response(stub_name)
  file = File.open(File.join(File.dirname(__FILE__), "support", "webstub", stub_name))
  BW::JSON.parse file.read
end
