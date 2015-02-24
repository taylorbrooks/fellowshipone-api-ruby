require "faraday"
require "faraday_middleware"
require "simple_oauth"

module FellowshipOne
  class Client
    attr_reader :token, :secret, :church_code, :environment

    def initialize(token, secret, church_code, production = true)
      @token       = token
      @secret      = secret
      @church_code = church_code
      @environment = production ? '' : '.staging'
    end

    # a temporary way to test getting funds
    def fund
      get("/giving/v1/funds")
    end

    def get(path)
      connection.get do |req|
        req.url path
      end.body
    end

    private

    def connection
      @connection ||= Faraday.new("https://#{church_code}#{environment}.fellowshiponeapi.com") do |connection|
        connection.request  :json
        connection.request  :oauth, oauth_data
        connection.response :xml,  :content_type => /\bxml$/
        connection.response :json, :content_type => /\bjson$/
        connection.adapter  Faraday.default_adapter
      end
    end

    def oauth_data
      {
        consumer_key: consumer_key,
        consumer_secret: consumer_secret,
        token: token,
        token_secret: secret
      }
    end

    def consumer_key
      'replace with your consumer key'
    end

    def consumer_secret
      'replace with your consumer secret'
    end
  end
end
