# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Post reprensents a Facebook post. Post provides getters for:
  #   :id, :url, :created_at, :type, :message, and :length.
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

    # @param [Hash] options the options to initialize an instance of Fb::Post.
    # @option [String] :id The post id.
    # @option [String] :message The status message in the post or post story.
    # @option [String] :url URL to the permalink page of the post.
    # @option [String] :created_time The time the post was initially published.
    # @option [String] :type A string indicating the object type of this post.
    # @option [String] :properties of the post (e.g. length).
    def initialize(options = {})
      @id = options[:id]
      @url = options[:permalink_url]
      @created_at = Time.strptime(options[:created_time], '%Y-%m-%dT%H:%M:%S+0000')
      @type = options[:type]
      @message = options[:message]
      @length = options.fetch(:properties, []).find(-> { {'text' => 'n/a'} }) do |property|
        property['name'] == 'Length'
      end['text']
    end

    # @return [String] the representation of the post.
    def to_s
      %Q(#<#{self.class.name} #{@id} "#{@type}">)
    end
  end
end
