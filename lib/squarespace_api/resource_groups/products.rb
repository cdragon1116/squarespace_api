module SquarespaceApi
  module ResourceGroups
    class Products < ResourceGroup
      allowed_actions :create, :all, :create, :delete, :update, :find_by_ids

      def find(id)
        products = where(id: id)
        products ? products.first : nil
      end

      private

      def parse_collection(response)
        response.body['products']
      end
    end
  end
end
