module Fb
  # Provides a wrapper for HTTPRequest when the result has pagination links.
  # @api private
  class PaginatedRequest < HTTPRequest
    # Sends the request and returns the response with the body parsed from JSON.
    # If the response body contains a link to the next page, fetches that page
    # as well and combines the data with the previous page.
    # @return [Net::HTTPResponse] if the request succeeds.
    # @raise [Fb::HTTPError] if the request fails.
    def run
      response = super
      while response.body.dig 'paging', 'next'
        after = response.body.dig 'paging', 'cursors', 'after'
        next_params = @params.merge after: after, limit: 100
        next_request = HTTPRequest.new path: @path, params: next_params
        next_body = next_request.run.body
        response.body['paging'] = next_body['paging']
        response.body['data'].concat next_body['data']
      end
      response
    end
  end
end
