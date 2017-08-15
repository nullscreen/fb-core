# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :url, :created_at, :type, :message, :length, engaged_users,
  #   video_views, video_views_organic, video_views_paid, and total_minutes_watched.
  class Post

    # @option [String] the post’s unique ID.
    attr_reader :id

    # @option [String] the post’s permanent url.
    attr_reader :url

    # @option [Time] the post’s creation time.
    attr_reader :created_at

    # @option [String] the post’s type.
    attr_reader :type

    # @option [String] the post’s message.
    attr_reader :message

    # @option [String] the attached video's length or n/a.
    attr_reader :length

    # @option [Integer] the number of people who clicked anywhere on the post.
    attr_reader :engaged_users

    # @option [Integer] video views of 3 seconds or more.
    attr_reader :video_views

    # @option [Integer] organic video views of 3 seconds or more.
    attr_reader :video_views_organic

    # @option [Integer] paid video views of 3 seconds or more.
    attr_reader :video_views_paid

    # @option [Integer] the total number of milliseconds your video was watched.
    attr_reader :video_view_time

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [String] :id The post id.
    # @option [String] :message The status message in the post or post story.
    # @option [String] :url URL to the permalink page of the post.
    # @option [String] :created_time The time the post was initially published.
    # @option [String] :type A string indicating the object type of this post.
    # @option [String] :properties of the post (e.g. length).
    # @option [Integer] :post_engaged_users The number of people who clicked anywhere on the post.
    # @option [Integer] :post_video_views Video views of 3 seconds or more.
    # @option [Integer] :post_video_views_organic Organic video views of 3 seconds or more.
    # @option [Integer] :post_video_views_paid Paid video views of 3 seconds or more.
    # @option [Integer] :post_video_view_time Total video view time (miliseconds).
    def initialize(options = {})
      @id = options[:id]
      @url = options[:permalink_url]
      @created_at = Time.strptime(options[:created_time], '%Y-%m-%dT%H:%M:%S+0000')
      @type = options[:type]
      @message = options[:message]
      @length = options.fetch(:properties, []).find(-> { {'text' => 'n/a'} }) do |property|
        property['name'] == 'Length'
      end['text']
      @engaged_users = options[:post_engaged_users] if options[:post_engaged_users]
      @video_views = options[:post_video_views] if options[:post_video_views]
      @video_views_organic = options[:post_video_views_organic] if options[:post_video_views_organic]
      @video_views_paid = options[:post_video_views_paid] if options[:post_video_views_paid]
      @video_view_time = options[:post_video_view_time] if options[:post_video_view_time]
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@type}">)
    end
  end
end
