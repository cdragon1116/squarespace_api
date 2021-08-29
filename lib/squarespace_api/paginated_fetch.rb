module SquarespaceApi
  module PaginatedFetch
    def self.build(params = {}, &_block)
      loop do
        response = yield(params)

        has_next_page = response.dig('pagination', 'hasNextPage').to_s == 'true'
        break unless has_next_page
        params = { cursor:  response.dig('pagination', 'nextPageCursor') }
      end
    end
  end
end
