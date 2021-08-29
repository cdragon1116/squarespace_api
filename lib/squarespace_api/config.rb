module SquarespaceApi
  class Config
    STABLE_VERSION = '1.0'.freeze
    attr_accessor :client_id, :client_secret,
      :api_version, :access_token,
      :base_url

    def initialize(options = {})
      @api_version   = options[:api_version] || STABLE_VERSION
      @access_token  = options[:access_token]
      @client_id     = options[:client_id] || ENV['SQUARESPACE_CLIENT_ID']
      @client_secret = options[:client_secret] || ENV['SQUARESPACE_CLIENT_SECRET']
    end

    def base_url
      "https://api.squarespace.com".freeze
    end

    def oauth_base_url
      "https://login.squarespace.com/api/1/login/oauth/provider".freeze
    end

    def encoded_oauth_token
      Base64.strict_encode64("#{client_id}:#{client_secret}").to_s
    end
  end
end
