module SquarespaceApi
  module ResourceGroups
    class InventoryAdjustments < ResourceGroup
      PATH = 'commerce/inventory/adjustments'.freeze
      allowed_actions :create
    end
  end
end
