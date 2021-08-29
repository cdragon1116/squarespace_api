module SquarespaceApi
  class Resource
    def initialize(connection:)
      @connection = connection
    end

    def resource_path
      self.class::PATH
    end

    def get
      connection.get(resource_path).body
    end

    protected

    attr_reader :connection
  end
end
