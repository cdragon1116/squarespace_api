module SquarespaceApi
  module ResourceGroups
    class ProductVariants < ResourceGroup
      PATH = 'commerce/products/:product_id/variants'.freeze
      allowed_actions :create, :delete, :update
    end
  end
end
