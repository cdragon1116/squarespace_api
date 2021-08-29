module SquarespaceApi
  class Client
    def initialize(config = nil)
      @config = config || SquarespaceApi.config
      @connection = Connection.new(@config)
    end

    %w(
      orders
      order_fulfillments
      products
      product_variants
      product_images
      product_variant_images
      profiles
      store_pages
      inventory
      inventory_adjustments
      transactions
      webhook_subscriptions
      tokens
    ).each do |resource|
      define_method(resource) do
        @connection.with_app_session do
          return instance_variable_get(:"@_#{resource}") if instance_variable_get(:"@_#{resource}")
          instance_variable_set(
            :"@_#{resource}",
            Module
            .const_get("SquarespaceApi::ResourceGroups::#{resource.to_camelcase}")
            .new(connection: @connection)
          )
        end
      end
    end

   %w(website).each do |resource|
      define_method(resource) do
        @connection.with_app_session do
          Module.const_get("SquarespaceApi::Resources::#{resource.to_camelcase}").new(connection: @connection).get
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
