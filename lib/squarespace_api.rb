require 'helper/string.rb'
require 'squarespace_api/config'
require 'squarespace_api/version'
require 'squarespace_api/resource'
require 'squarespace_api/resource_group'
require 'squarespace_api/client'
require 'squarespace_api/connection'
require 'squarespace_api/paginated_fetch'
require 'squarespace_api/resource_group_actions'

# Load all resource_groups, resources
Dir.glob("#{File.dirname(__FILE__)}/squarespace_api/resources/*").each { |file| require(file) }
Dir.glob("#{File.dirname(__FILE__)}/squarespace_api/resource_groups/*").each { |file| require(file) }

module SquarespaceApi
  class << self
    def configure
      yield config if block_given?
      config
    end

    def config
      @_config ||= Config.new
    end
  end
end
