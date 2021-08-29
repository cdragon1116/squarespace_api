require 'securerandom'
require "faraday"
require 'faraday_middleware'
require "json"

module SquarespaceApi
  class Connection
    DEFAULT_HEADERS = {
      'Content-Type' => 'application/json',
      'User-Agent' => 'SquarespaceApi'
    }.freeze

    attr_reader :config

    def initialize(config)
      @config = config
      @connection = Faraday.new do |connection|
        connection.headers = DEFAULT_HEADERS
        connection.response :json
      end

      initialize_app_session if config.access_token
    end

    def get(path, params: {}, headers: {})
      handle_response(connection.get(path, params, connection.headers.merge(headers)))
    end

    def post(path, params: {}, headers: {})
      handle_response(connection.post(path, params, connection.headers.merge(headers)))
    end

    def delete(path, params: {}, headers: {})
      handle_response(connection.delete(path, params, connection.headers.merge(headers)))
    end

    def upload_file(path, file_path)
      temp_connection = Faraday.new(url: api_base_url) do |f|
        f.request :multipart
        f.response :json
        f.headers = DEFAULT_HEADERS.merge(
          'Authorization' => "Bearer #{config.access_token}",
          'Content-Type' => 'multipart/form-data',
        )
      end.post(path, { file: Faraday::FilePart.new(file_path, 'text/x-ruby') })
    end

    def with_idempotency_key
      @connection.headers['Idempotency-Key'] = SecureRandom.hex
      yield
    end

    def with_app_session
      initialize_app_session
      yield
    end

    def initialize_app_session
      @connection.headers['Authorization'] = "Bearer #{config.access_token}"
      @connection.url_prefix = api_base_url
      self
    end

    def with_oauth_session
      initialize_oauth_session
      yield
    end

    def initialize_oauth_session
      @connection.headers['Authorization'] = "Basic #{config.encoded_oauth_token}"
      @connection.url_prefix = config.oauth_base_url
      self
    end

    private

    attr_reader :connection

    def api_base_url
      "#{config.base_url}/#{config.api_version}"
    end

    def handle_response(response)
      return response if response.success?
      error_message = response.body.dig('message')
      case response.status
      when 400
        raise SquarespaceApi::Errors::BadRequest, error_message
      when 401
        raise SquarespaceApi::Errors::Unauthorized, error_message
      when 404
        raise SquarespaceApi::Errors::NotFound, error_message
      when 405
        raise SquarespaceApi::Errors::MethodNotAllowed, error_message
      when 429
        raise SquarespaceApi::Errors::TooManyRequests, error_message
      else
        response
      end
    end
  end

  module Errors
    class BadRequest < StandardError; end
    class Unauthorized < StandardError; end
    class NotFound < StandardError; end
    class MethodNotAllowed < StandardError; end
    class TooManyRequests < StandardError; end
  end
end
