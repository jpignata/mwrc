require "english"
require "socket"
require "timeout"
require "rspec"
require "webmock/rspec"

$LOAD_PATH << File.join(File.dirname(__FILE__), "..", "lib") <<
              File.join(File.dirname(__FILE__), "..", "spec")

Dir["./spec/support/*.rb"].each do |support_helper|
  require support_helper
end

Thread.abort_on_exception = true
