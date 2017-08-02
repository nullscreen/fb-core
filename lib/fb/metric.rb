# Ruby client to authenticate a Facebook user.
# @see http://www.rubydoc.info/gems/Fb/
module Fb
  # Fb::Metric reprensents a Facebook insights metric. Metric provides getters
  # for: :name, :period, :title, :description, :id, and :values.
  class Metric
    attr_reader :name, :period, :title, :description, :id, :values

    # @param [Hash] options the options to initialize an instance of Fb::Metric.
    # @option [String] :name the shorthand name of the metric.
    # @option [String] :period the aggregate period for this metric (e.g. day).
    # @option [String] :title the full name of the metric.
    # @option [String] :description a brief description of the metric.
    # @option [<Hash>] :values a collection of daily values with end times.
    # @option [String] :id formatted as '<resource_id>/insights/<name>/<period>'.
    def initialize(options = {})
      @name = options[:name]
      @period = options[:period]
      @title = options[:title]
      @description = options[:description]
      @id = options[:id]
      @values = options[:values].map do |value_data|
        OpenStruct.new(
          value: value_data.fetch('value', 0),
          end_time: Time.parse(value_data['end_time'])
        )
      end
    end
  end
end
