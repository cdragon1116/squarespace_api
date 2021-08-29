module SquarespaceApi
  module ResourceGroups
    class Inventory < ResourceGroup
      PATH = 'commerce/inventory'.freeze
      allowed_actions :all, :update, :find_by_ids

      def find(id)
        inventory = where(id: id)
        inventory ? inventory.first : nil
      end

      def parse_collection(response)
        response.body['inventory']
      end
    end
  end
end
