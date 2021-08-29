module SquarespaceApi
  module ResourceGroups
    class Transactions < ResourceGroup
      allowed_actions :all, :find_by_ids

      def find(id)
        transactions = find_by_ids([id])
        transactions ? transactions.first : nil
      end

      private

      def parse_collection(response)
        response.body['documents']
      end
    end
  end
end
