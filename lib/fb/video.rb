module Fb
  # Fb::Video represents a Facebook video. Fb::Video provides getter methods.
  # @see https://developers.facebook.com/docs/graph-api/reference/video/
  class Video

    # @option [String] the video’s unique ID.
    attr_reader :id

    # @option [String] the video’s permanent URL.
    attr_reader :url

    # @option [String] the video’s title or caption.
    attr_reader :title

    # @option [String] the video’s description or caption.
    attr_reader :description

    # @option [Array<String>] the video’s custom labels.
    attr_reader :custom_labels

    # @return [Integer] the number of comments on the video.
    attr_reader :comment_count

    # @return [Integer] the number of likes on the video.
    attr_reader :like_count

    # @return [Integer] the number of reactions on the video.
    attr_reader :reaction_count

    # @option [Array<String>] the video’s content tags.
    attr_reader :content_tags

    # @option [Array<Integer>] the video’s ad breaks in milliseconds.
    attr_reader :ad_breaks

    # @option [Float] the video’s length.
    attr_reader :length

    # @option [Time] the time the video was initially published.
    attr_reader :created_at

    # @option [Time] the time when the video post was created.
    attr_reader :backdated_time

    # @option [Integer] total number of times the video was viewed for 3 seconds
    # or viewed to the end, whichever happened first. total_video_views.
    # @see https://developers.facebook.com/docs/graph-api/reference/video/video_insights/
    attr_reader :total_views

    # @option [Integer] the total_video_views_unique of the video.
    attr_reader :total_views_unique

    # @option [Integer] the total_video_avg_time_watched of the video.
    attr_reader :total_avg_time_watched

    # @option [Integer] the total_video_views_autoplayed of the video.
    attr_reader :total_views_autoplayed

    # @option [Integer] the total_video_views_clicked_to_play of the video.
    attr_reader :total_views_clicked_to_play

    # @option [Integer] the total_video_complete_views_auto_played of the video.
    attr_reader :total_complete_views_auto_played

    # @option [Integer] the total_video_complete_views_clicked_to_play of the video.
    attr_reader :total_complete_views_clicked_to_play

    # @option [Integer] the total_video_views_sound_on of the video.
    attr_reader :total_views_sound_on

    # @option [Integer] the total_video_10s_views_auto_played of the video.
    attr_reader :total_10s_views_sound_on

    # @option [Integer] the number of impressions of the video.
    attr_reader :total_impressions

    # @option [Integer] number of people your video was served to.
    attr_reader :total_impressions_unique

    # @option [Integer] number of times your video was viewed for 95% or complete.
    attr_reader :total_complete_views

    # @option [Integer] number of unique viewers who watched for 95% or complete.
    attr_reader :total_complete_views_unique

    # @param [Hash] options the options to initialize an instance of Fb::Video.
    def initialize(options = {})
      @id = options[:id]
      @url = options[:permalink_url]
      @title = options[:title]
      @description = options[:description]
      @custom_labels = options[:custom_labels] ? Array(options[:custom_labels]) : []

      @comment_count = options[:comments]['summary']['total_count'] if options[:comments]
      @like_count = options[:likes]['summary']['total_count'] if options[:likes]
      @reaction_count = options[:reactions]['summary']['total_count'] if options[:reactions]
      @content_tags = options[:content_tags] ? Array(options[:content_tags]) : []
      @ad_breaks = options[:ad_breaks] ? Array(options[:ad_breaks]) : []
      @length = options[:length]
      @created_at = Time.parse(options[:created_time]) if options[:created_time]
      @backdated_time = Time.parse(options[:backdated_time]) if options[:backdated_time]

      @total_views = options[:total_video_views]
      @total_views_unique = options[:total_video_views_unique]
      @total_avg_time_watched = options[:total_video_avg_time_watched]
      @total_views_autoplayed = options[:total_video_views_autoplayed]
      @total_views_clicked_to_play = options[:total_video_views_clicked_to_play]
      @total_complete_views_auto_played = options[:total_video_complete_views_auto_played]
      @total_complete_views_clicked_to_play = options[:total_video_complete_views_clicked_to_play]
      @total_views_sound_on = options[:total_video_views_sound_on]
      @total_10s_views_sound_on = options[:total_video_10s_views_sound_on]

      @total_impressions = options[:total_video_impressions]
      @total_impressions_unique = options[:total_video_impressions_unique]
      @total_complete_views = options[:total_video_complete_views]
      @total_complete_views_unique = options[:total_video_complete_views_unique]
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@length}">)
    end
  end
end
