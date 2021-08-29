require 'squarespace_api/resource_groups'

module SquarespaceApi
  class Client
    def initialize(config = nil)
      @config = config || SquarespaceApi.config
      @connection = Connection.new(@config)
    end

    ResourceGroups::Config.keys.each do |resource|
      define_method(resource) do
        @connection.with_app_session do
          return instance_variable_get(:"@_#{resource}") if instance_variable_get(:"@_#{resource}")
          instance_variable_set(
            :"@_#{resource}",
            Module
            .const_get(ResourceGroups::Config[resource]['class'])
            .new(connection: @connection)
          )
        end
      end
    end

    Resources::Config.keys.each do |resource|
      define_method(resource) do
        @connection.with_app_session do
          Module.const_get(Resources::Config[resource]['class']).new(connection: @connection).get
        end
      end
    end

    def build_oauth_authorize_url(params)
      @config.oauth_base_url +
        '/authorize?' +
        { client_id: @config.client_id }.merge(params).map { |k, v| "#{k}=#{v}" }.join('&')
    end
  end
end
