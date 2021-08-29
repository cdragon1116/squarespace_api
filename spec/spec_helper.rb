require "webmock/rspec"
require "pry"

$LOAD_PATH.unshift File.expand_path("../lib", __dir__)
require 'squarespace_api'
require 'json'

RSpec.configure do |config|
end
