module SquarespaceApi
  module ResourceGroups
    class ProductImages < ResourceGroup
      allowed_actions :update, :delete

      def upload(file_path, params = {})
        parse(
          connection.upload_file(UriComponentBuidler.construct(resources_path, params), file_path)
        )
      end

      def status(id, params)
        parse(
          connection
          .get(UriComponentBuidler.construct(resource_path, params.merge(id: id)) + "/status")
        )
      end

      def order(id, params)
        params = params.merge(id: id)
        parse(
          connection
          .post(UriComponentBuidler.construct(resource_path, params) + "/order", params: params.to_json)
        )
      end
    end
  end
end
