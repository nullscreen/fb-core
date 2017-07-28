module Fb
  # @private
  class DataHelper
    def self.symbolize_keys(hash)
      {}.tap do |new_hash|
        hash.each_key{|key| new_hash[key.to_sym] = hash[key]}
      end
    end
  end
end
