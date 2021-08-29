module SquarespaceApi
  module ResourceGroups
    class Profiles < ResourceGroup
      allowed_actions :all, :create

      def find(id)
        profiles = where(id: id)
        profiles ? profiles.first : nil
      end

      def update(params = {})
        create(params)
      end

      private

      def parse_collection(response)
        response.body['profiles']
      end
    end
  end
end
