module Fb
  # Provides a base class for Facebook resources (users, pages, ...)
  class Resource
  private
    def symbolize_keys(hash)
      {}.tap do |new_hash|
        hash.each_key{|key| new_hash[key.to_sym] = hash[key]}
      end
    end
  end
end
