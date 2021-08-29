module SquarespaceApi
  class ResourceGroup
    def initialize(connection:)
      @connection = connection
    end

    protected

    attr_reader :connection, :resource, :resource_path

    def resource_path
      resources_path + "/:id"
    end

    def resources_path
      self.class::PATH
    end

    def parse(response)
      response.body || true
    end

    def parse_collection
      raise 'This method should be implemented in a subclass.'
    end

    class << self
      def allowed_actions(*args)
        args.each do |action|
          self.send(:include, Module.const_get("SquarespaceApi::ResourceGroupActions::#{action.to_s.to_camelcase}"))
        end
      end
    end
  end
end
