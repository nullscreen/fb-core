# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :title, :url, :created_time, and :type.
  class Post
    attr_reader :id, :title, :url, :created_time, :type

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [String] :id The post id.
    # @option [String] :title The status message in the post or post story.
    # @option [String] :url URL to the permalink page of the post.
    # @option [String] :created_time The time the post was initially published.
    # @option [String] :type A string indicating the object type of this post.
    def initialize(options = {})
      @id = options[:id]
      @url = options[:permalink_url]
      @created_time = options[:created_time]
      @type = options[:type]
      @title = options[:message] || options[:story] || build_title
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@type}">)
    end

  private

    def build_title
      "#{@type} posted #{@created_time} available at #{@url}"
    end
  end
end
