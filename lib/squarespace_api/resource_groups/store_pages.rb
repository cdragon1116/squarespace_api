module SquarespaceApi
  module ResourceGroups
    class StorePages < ResourceGroup
      PATH = 'commerce/store_pages'.freeze
      allowed_actions :all

      private

      def parse_collection(response)
        response.body['storePages']
      end
    end
  end
end
