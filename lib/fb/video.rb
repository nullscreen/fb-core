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

    # @option [Array<String>] the video’s custom labels.
    attr_reader :custom_labels

    # @param [Hash] options the options to initialize an instance of Fb::Video.
    # @option [String] :id The video id.
    def initialize(options = {})
      @id = options[:id]
      @url = options[:permalink_url]
      @title = options[:title]
      @custom_labels = options[:custom_labels] ? Array(options[:custom_labels]) : Array.new
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id}>)
    end
  end
end
