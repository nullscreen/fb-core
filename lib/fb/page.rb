module Fb
  # Provides methods to interact with Facebook pages through the Graph API.
  # @see https://developers.facebook.com/docs/graph-api/reference/page/
  class Page < Resource
    # @option [String] the page’s unique ID.
    attr_reader :id

    # @option [String] the page’s name.
    attr_reader :name

    # @option [String] the page’s category.
    attr_reader :category

    # @param [Hash] options to initialize a Page object.
    # @option [String] :id The page’s unique ID.
    # @option [String] :name The page’s name.
    # @option [String] :category The page’s category.
    # @option [String] :access_token an access token for the page.
    def initialize(options = {})
      @id = options[:id]
      @name = options[:name]
      @category = options[:category]
      @access_token = options[:access_token]
    end

    # @return [Array<Fb::Post>] the posts published on the page.
    def posts
      @posts ||= begin
        fields = %i(type created_time).join ','
        params = {access_token: @access_token, limit: 100, fields: fields}
        request = PaginatedRequest.new path: "/v2.9/#{@id}/posts", params: params
        request.run.body['data'].map do |post_data|
          Post.new symbolize_keys post_data
        end
      end
    end

    # @return [String] the representation of the page.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@name}">)
    end
  end
end
