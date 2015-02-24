Dir[File.expand_path('../fellowship_one/client/*.rb', __FILE__)].each{|f| require f}
require File.expand_path('../fellowship_one/client.rb', __FILE__)

module FellowshipOne
  class << self
    attr_accessor :client

    def get(*args, &block)
      self.client.get(*args)
    end

    def post(*args, &block)
      self.client.post(*args)
    end

    def put(*args, &block)
      self.client.put(*args)
    end

    def delete(*args, &block)
      self.client.delete(*args)
    end
  end

  class Api

    class << self
      attr_reader :church_code, :consumer_key, :consumer_secret, :api_token, :api_secret, :is_production
    end

    def self.establish_connection(church_code, consumer_key, consumer_secret, callback_url, production = true)
      if church_code.nil? or consumer_key.nil? or consumer_secret.nil?
        raise FellowshipOneExceptions::UnableToConnectToFellowshipOne.new('Church code, Consumer Key and Consumer Secret cannot be nil.')
      end

      consumer_env = production ? '' : '.staging' # Yes, blank is production

      puts "F1 URL: https://#{church_code}#{consumer_env}.fellowshiponeapi.com"

      consumer = OAuth::Consumer.new(consumer_key, consumer_secret,
                                     :site => "https://#{church_code}#{consumer_env}.fellowshiponeapi.com",
                                     :request_token_path => '/v1/Tokens/RequestToken',
                                     :authorize_path     => '/v1/PortalUser/Login',
                                     :access_token_path  => '/v1/Tokens/AccessToken')

      consumer.get_request_token(:oauth_callback => callback_url)
    end

    def self.connect(church_code, consumer_key, consumer_secret, oauth_token, oauth_secret, production = true)
      raise FellowshipOneExceptions::UnableToConnectToFellowshipOne.new('Church Code, Token and Secret cannot be nil.') if oauth_token.nil? or oauth_secret.nil?
      @church_code = church_code
      @consumer_key = consumer_key
      @consumer_secret = consumer_secret      
      @api_token = oauth_token
      @api_secret = oauth_secret
      @is_production = production
    end    

  end

end
