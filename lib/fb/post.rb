# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :title, :url, :created_time, and :type.
  class Post
    # @option [String] the post’s unique ID.
    attr_reader :id

    # @option [String] the post’s type.
    attr_reader :type

    # @option [Time] the post’s creation time.
    attr_reader :created_at

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [String] :id the post id.
    # @option [String] :type the post’s type.
    # @option [String] :created_time the post’s creation time in iso8601 format.
    def initialize(options = {})
      @id = options[:id]
      @type = options[:type]
      @created_at = Time.parse(options[:created_time]) if options[:created_time]
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@type}">)
    end
  end
end
