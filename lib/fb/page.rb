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

    # @return [Hash] a hash of metrics mapped to their values.
    # @param [Array<String, Symbol>] :metrics the metrics to fetch.
    # @option [Date] :until only sum seven days before this date.
    def weekly_metrics(metrics, options = {})
      since_date = options.fetch :until, Date.today - 1
      params = {period: :week, since: since_date, until: since_date + 2}
      metrics = insights Array(metrics), params
      metrics.map {|m| [m['name'].to_sym, m['values'].last.fetch('value', 0)]}.to_h
    end

    # @return [Integer] the number of views of the page.
    # @param [Hash] options the options
    # @option [Date] :until only count the views until this day.
    def view_count(options = {})
      views = single_metric 'page_views_total', period: :day, since: '1652 days ago'
      if options[:until]
        views.select!{|v| v['end_time'] < options[:until].strftime('%Y-%m-%dT%H:%M:%S+0000')}
      end
      views.sum{|x| x.fetch('value', 0)}
    end

    # @return [Integer] the number of likes of the page.
    # @param [Hash] options the options
    # @option [Date] :until only count the likes until this day.
    def like_count(options = {})
      since_date = options.fetch :until, Date.today - 1
      likes = single_metric 'page_fans', since: since_date, until: since_date + 2
      likes.last.fetch('value', 0)
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

    def single_metric(metric, options = {})
      insights = insights Array(metric), options
      insights.find{|data| data['name'] == metric}['values']
    end

    def insights(metrics, options = {})
      params = options.merge metric: metrics.join(','), access_token: @access_token
      request = HTTPRequest.new path: "/v2.9/#{@id}/insights", params: params
      request.run.body['data']
    end
  end
end
