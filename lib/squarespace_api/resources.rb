require 'yaml'

module SquarespaceApi
  module Resources
    Config = YAML.load_file('lib/squarespace_api/config/resources.yml').freeze
  end
end
