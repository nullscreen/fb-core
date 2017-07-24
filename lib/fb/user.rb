module Fb
  # Provides methods to interact with Facebook users through the Graph API.
  # @see https://developers.facebook.com/docs/graph-api/reference/user/
  class User
    # @param [Hash] options to initialize a User object.
    # @option [String] :access_token an access token for the user.
    def initialize(options = {})
      @access_token = options[:access_token]
    end

    # @return [String] the user’s email address.
    def email
      @email ||= begin
        params = {fields: :email, access_token: @access_token}
        request = HTTPRequest.new path: '/me', params: params
        request.run.body['email']
      end
    end

    # @return [Array<Fb::Page>] the pages managed by the user.
    def pages
      @pages ||= begin
        params = {access_token: @access_token}
        request = HTTPRequest.new path: '/me/accounts', params: params
        request.run.body['data'].map do |page_data|
          Page.new symbolize_keys(page_data)
        end
      end
    end

  private

    def symbolize_keys(hash)
      {}.tap do |new_hash|
        hash.each_key{|key| new_hash[key.to_sym] = hash[key]}
      end
    end
  end
end
