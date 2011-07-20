$:.unshift File.join(File.dirname(__FILE__), '..', 'lib')

require 'rubygems'
require 'bundler/setup'

require 'tassadar'

RSpec.configure do |config|
  config.mock_with :rr
end

