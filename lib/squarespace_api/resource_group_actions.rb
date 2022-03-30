require 'squarespace_api/paginated_fetch'
require 'helper/uri_component_builder'

module SquarespaceApi
  module ResourceGroupActions
    module All
      def all(params = {}, &_block)
        PaginatedFetch.build(params) do |paginated_params|
          query_result = connection
            .get(UriComponentBuidler.construct(resources_path, paginated_params), params: paginated_params)
          response = parse_collection(query_result)
          pagination = parse_pagination(query_result)

          return response unless block_given?
          yield(response)
          pagination
        end
      end

      alias_method :where, :all
    end

    module Find
      def find(id, params = {})
        parse(
          connection
          .get(UriComponentBuidler.construct(resource_path, params.merge(id: id)))
        )
      end
    end

    module FindByIds
      def find_by_ids(ids = [])
        parse_collection(
          connection
          .get(UriComponentBuidler.construct(resource_path, { id: ids.join(",") }))
        )
      end
    end

    module Create
      def create(params = {})
        connection.with_idempotency_key do
          parse(
            connection
            .post(UriComponentBuidler.construct(resources_path, params), params: params.to_json)
          )
        end
      end
    end

    module Update
      def update(id, params = {})
        params = params.merge(id: id)
        parse(
          connection
          .post(UriComponentBuidler.construct(resource_path, params), params: params.to_json)
        )
      end
    end

    module Delete
      def delete(id, params = {})
        parse(
          connection
          .delete(UriComponentBuidler.construct(resource_path, params.merge(id: id)))
        )
      end
    end
  end
end
