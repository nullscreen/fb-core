module Fb
  # Provides methods to interact with Facebook pages through the Graph API.
  # @see https://developers.facebook.com/docs/graph-api/reference/page/
  class Page
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
    def initialize(options = {})
      @id = options[:id]
      @name = options[:name]
      @category = options[:category]
    end

    # @return [Array<Fb::Post>] a collection of posts.
    def posts
      @posts ||= begin
        fetch_posts.map do |post_data|
          Fb::Post.new DataHelper.symbolize_keys(post_data)
        end
      end
    end

    # @return [String] the representation of the page.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@name}">)
    end

  private

    def fetch_posts
      result = []
      response = HTTPRequest.new(path: "/v2.9/#{@id}/posts",
        params: posts_params).run.body
      loop do
        if response["paging"].key?("next")
          result << response["data"]
          next_page = response["paging"]["cursors"]["after"]
          paging_params = posts_params.merge(after: next_page)
          response = HTTPRequest.new(path: "/v2.9/#{@id}/posts",
            params: paging_params).run.body
        else
          result << response["data"]
          break
        end
      end
      result.flatten
    end

    def posts_params
      {
        fields: 'type,created_time,message,story,permalink_url',
        limit: 100,
        access_token: ENV['FB_TEST_ACCESS_TOKEN']
      }
    end
  end
end
