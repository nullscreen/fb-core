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

    # @return [Hash{Symbol => Fb::Metric}] a hash of metric names mapped
    #   to Fb::Metric objects.
    def insights
      @insights ||= begin
        request = HTTPRequest.new path: "/v2.9/#{@id}/insights", params: insights_params
        request.run.body['data'].map do |metric_data|
          [metric_data.fetch('name').to_sym, Metric.new(symbolize_keys metric_data)]
        end.to_h
      end
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

  private

    def insights_params
      {}.tap do |params|
        params[:access_token] = @access_token
        params[:period] = :day
        params[:metric] = page_metrics.join ','
        params[:since] = '1652 days ago'
      end
    end

    def page_metrics
      %i(page_fans page_video_views page_impressions page_impressions_paid
      page_impressions_organic page_fan_adds page_post_engagements
      page_engaged_users)
    end
  end
end
