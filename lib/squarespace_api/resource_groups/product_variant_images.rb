module SquarespaceApi
  module ResourceGroups
    class ProductVariantImages < ResourceGroup
      PATH = 'commerce/products/:product_id/variants/:variant_id/image'.freeze
      allowed_actions :create
    end
  end
end
