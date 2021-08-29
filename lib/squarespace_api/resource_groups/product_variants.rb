module SquarespaceApi
  module ResourceGroups
    class ProductVariants < ResourceGroup
      allowed_actions :create, :delete, :update
    end
  end
end
