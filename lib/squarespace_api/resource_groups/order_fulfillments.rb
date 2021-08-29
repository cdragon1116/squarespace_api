module SquarespaceApi
  module ResourceGroups
    class OrderFulfillments < ResourceGroup
      PATH = 'commerce/orders/:order_id/fulfillments'.freeze
      allowed_actions :create
    end
  end
end
