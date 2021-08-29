module SquarespaceApi
  module ResourceGroups
    class Orders < ResourceGroup
      allowed_actions :create, :all, :find

      def fulfil(id, params = {})
        OrderFulfillments.new(connection: connection).create(params.merge(order_id: id))
      end

      private

      def parse_collection(response)
        response.body['result']
      end
    end
  end
end
