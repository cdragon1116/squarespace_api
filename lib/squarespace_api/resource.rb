module SquarespaceApi
  class Resource
    def initialize(connection:)
      @connection = connection
      @resource_config = load_config
    end

    def load_config
      Resources::Config[self.class.name.split('::').last.to_snakecase]
    end

    def resource_path
      @resource_config['path']
    end

    def get
      connection.get(resource_path).body
    end

    protected

    attr_reader :connection
  end
end
