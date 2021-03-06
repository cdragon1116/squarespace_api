module SquarespaceApi
  module ResourceGroups
    class Tokens < ResourceGroup
      PATH = 'tokens'.freeze
      allowed_actions :create

      def create(params)
        connection.with_oauth_session do
          super(params)
        end
      end
    end
  end
end
