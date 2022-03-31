module SquarespaceApi
  module PaginatedFetch
    def self.build(params = {}, &_block)
      loop do
        pagination = yield(params)

        has_next_page = !!pagination&.dig('hasNextPage')
        break if not has_next_page
        params = { cursor:  pagination['nextPageCursor'] }
      end
    end
  end
end
