require 'yaml'

module SquarespaceApi
  module ResourceGroups
    Config = YAML.load_file('lib/squarespace_api/config/resource_groups.yml').freeze
  end
end
