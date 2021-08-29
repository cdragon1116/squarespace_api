module SquarespaceApi
  module ResourceGroups
    class StorePages < ResourceGroup
      allowed_actions :all

      private

      def parse_collection(response)
        response.body['storePages']
      end
    end
  end
end
