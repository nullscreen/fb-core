# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :url, :created_at, :type, :message, :length, engaged_users,
  #   video_views, video_views_organic, video_views_paid, and video_view_time.
  # @see https://developers.facebook.com/docs/graph-api/reference/v2.10/post
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

    # @return [Integer] the number of comments of the post.
    attr_reader :comment_count

    # @return [Integer] the number of likes of the post.
    attr_reader :like_count

    # @return [Integer] the number of reactions of the post.
    attr_reader :reaction_count

    # @return [Integer] the number of shares of the post.
    attr_reader :share_count

    attr_reader :video_complete_views_30s_autoplayed
    attr_reader :video_complete_views_30s_clicked_to_play
    attr_reader :video_complete_views_30s_organic
    attr_reader :video_complete_views_30s_paid
    attr_reader :video_complete_views_30s_unique

    # @option [Integer] the number of times your Page's post entered a person's screen.
    attr_reader :impressions

    attr_reader :impressions_unique
    attr_reader :impressions_paid
    attr_reader :impressions_paid_unique
    attr_reader :impressions_fan
    attr_reader :impressions_fan_unique
    attr_reader :impressions_fan_paid
    attr_reader :impressions_fan_paid_unique
    attr_reader :impressions_organic
    attr_reader :impressions_organic_unique
    attr_reader :impressions_viral

    # @option [Integer] the number of times people clicked on anywhere
    #   in your posts without generating a story.
    attr_reader :consumptions

    # @option [Integer] the number of people who clicked anywhere on the post.
    attr_reader :engaged_users

    attr_reader :negative_feedback

    # @option [Integer] people who have liked your page and engaged with your post.
    attr_reader :engaged_fan

    # @option [Integer] post reach by people who like your page.
    attr_reader :fan_reach

    attr_reader :reactions_like_total
    attr_reader :reactions_love_total
    attr_reader :reactions_wow_total
    attr_reader :reactions_haha_total
    attr_reader :reactions_sorry_total
    attr_reader :reactions_anger_total

    # @option [Integer] the average length of time people spent viewing
    #   your video, in milliseconds.
    attr_reader :video_avg_time_watched

    attr_reader :video_complete_views_organic
    attr_reader :video_complete_views_organic_unique
    attr_reader :video_complete_views_paid
    attr_reader :video_complete_views_paid_unique

    # @option [Integer] organic video views of 3 seconds or more.
    attr_reader :video_views_organic

    attr_reader :video_views_organic_unique

    # @option [Integer] paid video views of 3 seconds or more.
    attr_reader :video_views_paid

    attr_reader :video_views_paid_unique
    attr_reader :video_length

    # @option [Integer] video views of 3 seconds or more.
    attr_reader :video_views

    attr_reader :video_views_unique
    attr_reader :video_views_autoplayed
    attr_reader :video_views_clicked_to_play
    attr_reader :video_views_10s
    attr_reader :video_views_10s_unique
    attr_reader :video_views_10s_autoplayed
    attr_reader :video_views_10s_clicked_to_play
    attr_reader :video_views_10s_organic
    attr_reader :video_views_10s_paid
    attr_reader :video_views_10s_sound_on
    attr_reader :video_views_sound_on

    # @option [Integer] the total number of milliseconds your video was watched.
    attr_reader :video_view_time

    attr_reader :video_view_time_organic

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [String] :id The post id.
    # @option [String] :message The status message in the post or post story.
    # @option [String] :url URL to the permalink page of the post.
    # @option [String] :created_at The time the post was initially published.
    # @option [String] :type A string indicating the object type of this post.
    # @option [String] :properties of the post (e.g. length).
    # @option [Integer] :engaged_users The number of people who clicked anywhere on the post.
    # @option [Integer] :video_views Video views of 3 seconds or more.
    # @option [Integer] :video_views_organic Organic video views of 3 seconds or more.
    # @option [Integer] :video_views_paid Paid video views of 3 seconds or more.
    # @option [Integer] :video_view_time Total video view time (miliseconds).
    def initialize(options = {})
      @id = options[:id]
      @url = options[:permalink_url]
      @created_at = Time.strptime(options[:created_time], '%Y-%m-%dT%H:%M:%S+0000')
      @type = options[:type]
      @message = options[:message]
      @length = options.fetch(:properties, []).find(-> { {'text' => 'n/a'} }) do |property|
        property['name'] == 'Length'
      end['text']
      @share_count = options[:shares] ? options[:shares]["count"] : 0
      @comment_count = options[:comments]['summary']['total_count'] if options[:comments]
      @reaction_count = options[:reactions]['summary']['total_count'] if options[:reactions]
      @like_count = options[:likes]['summary']['total_count'] if options[:likes]

      @video_complete_views_30s_autoplayed = options[:post_video_complete_views_30s_autoplayed]
      @video_complete_views_30s_clicked_to_play = options[:post_video_complete_views_30s_clicked_to_play]
      @video_complete_views_30s_organic = options[:post_video_complete_views_30s_organic]
      @video_complete_views_30s_paid = options[:post_video_complete_views_30s_paid]
      @video_complete_views_30s_unique = options[:post_video_complete_views_30s_unique]
      @impressions = options[:post_impressions]
      @impressions_unique = options[:post_impressions_unique]
      @impressions_paid = options[:post_impressions_paid]
      @impressions_paid_unique = options[:post_impressions_paid_unique]
      @impressions_fan = options[:post_impressions_fan]
      @impressions_fan_unique = options[:post_impressions_fan_unique]
      @impressions_fan_paid = options[:post_impressions_fan_paid]
      @impressions_fan_paid_unique = options[:post_impressions_fan_paid_unique]
      @impressions_organic = options[:post_impressions_organic]
      @impressions_organic_unique = options[:post_impressions_organic_unique]
      @impressions_viral = options[:post_impressions_viral]
      @consumptions = options[:post_consumptions]
      @engaged_users = options[:post_engaged_users]
      @negative_feedback = options[:post_negative_feedback]
      @engaged_fan = options[:post_engaged_fan]
      @fan_reach = options[:post_fan_reach]
      @reactions_like_total = options[:post_reactions_like_total]
      @reactions_love_total = options[:post_reactions_love_total]
      @reactions_wow_total = options[:post_reactions_wow_total]
      @reactions_haha_total = options[:post_reactions_haha_total]
      @reactions_sorry_total = options[:post_reactions_sorry_total]
      @reactions_anger_total = options[:post_reactions_anger_total]
      @video_avg_time_watched = options[:post_video_avg_time_watched]
      @video_complete_views_organic = options[:post_video_complete_views_organic]
      @video_complete_views_organic_unique = options[:post_video_complete_views_organic_unique]
      @video_complete_views_paid = options[:post_video_complete_views_paid]
      @video_complete_views_paid_unique = options[:post_video_complete_views_paid_unique]
      @video_views_organic = options[:post_video_views_organic]
      @video_views_organic_unique = options[:post_video_views_organic_unique]
      @video_views_paid = options[:post_video_views_paid]
      @video_views_paid_unique = options[:post_video_views_paid_unique]
      @video_length = options[:post_video_length]
      @video_views = options[:post_video_views]
      @video_views_unique = options[:post_video_views_unique]
      @video_views_autoplayed = options[:post_video_views_autoplayed]
      @video_views_clicked_to_play = options[:post_video_views_clicked_to_play]
      @video_views_10s = options[:post_video_views_10s]
      @video_views_10s_unique = options[:post_video_views_10s_unique]
      @video_views_10s_autoplayed = options[:post_video_views_10s_autoplayed]
      @video_views_10s_clicked_to_play = options[:post_video_views_10s_clicked_to_play]
      @video_views_10s_organic = options[:post_video_views_10s_organic]
      @video_views_10s_paid = options[:post_video_views_10s_paid]
      @video_views_10s_sound_on = options[:post_video_views_10s_sound_on]
      @video_views_sound_on = options[:post_video_views_sound_on]
      @video_view_time = options[:post_video_view_time]
      @video_view_time_organic = options[:post_video_view_time_organic]
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@type}">)
    end
  end
end
