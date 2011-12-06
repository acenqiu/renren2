require 'oauth2'

module Renren2

  # The Renren2::Client class
  class Client < OAuth2::Client
  
    attr_reader :redirect_uri
    attr_accessor :token
    
    # Initializes a new Client from a authentication_code
    #
    # @param [String] code The Authorization Code value
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder
    def self.from_code(code, opts={}, &block)
      client = self.new(opts, &block)
      client.auth_code.get_token(code)
      
      client
    end
    
    # Initializes a new Client from a hash
    #
    # @param [Hash] a Hash contains access_token and expires
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder
    def self.from_hash(hash, opts={}, &block)
      client = self.new(opts, &block)
      client.get_token_from_hash(hash)
      
      client
    end

    # Initializes a new Client
    #
    # @param [Hash] opts the options to create the client with
    # @option opts [Hash] :connection_opts ({}) Hash of connection options to pass to initialize Faraday with
    # @option opts [FixNum] :max_redirects (5) maximum number of redirects to follow
    # @yield [builder] The Faraday connection builder 
    def initialize(opts={}, &block)
      id = Renren2::Config.api_key
      secret = Renren2::Config.api_secret
      @redirect_uri = Renren2::Config.redirect_uri
      
      options = {:site          => "https://graph.renren.com",
                 :authorize_url => "/oauth/authorize",
                 :token_url     => "/oauth/token",
                 :raise_errors  => false,
                 :ssl           => {:verify => false}}.merge(opts)
          
      super(id, secret, options, &block)
    end
    
    # Whether or not the client is authorized
    #
    # @return [Boolean]
    def is_authorized?
      !!token && !token.expired?
    end

    # Initializes an AccessToken by making a request to the token endpoint
    #
    # @param [Hash] params a Hash of params for the token endpoint
    # @param [Hash] access token options, to pass to the AccessToken object
    # @return [AccessToken] the initalized AccessToken
    def get_token(params, access_token_opts={})
      params = params.merge(:parse => :json)
      access_token_opts = access_token_opts.merge({:header_format => "OAuth2 %s", :param_name => "oauth_token"})
      
      @token = super(params, access_token_opts)
    end
    
    # Initializes an AccessToken from a hash
    #
    # @param [Hash] hash a Hash contains access_token and expires
    # @return [AccessToken] the initalized AccessToken
    def get_token_from_hash(hash)
      access_token = hash.delete('access_token') || hash.delete(:access_token) || hash.delete('oauth_token') || hash.delete(:oauth_token)
      opts = {:expires_at => hash.delete("expires") || hash.delete(:expires),
              :header_format => "OAuth2 %s",
              :param_name => "oauth_token"}.merge(hash)
      
      @token = OAuth2::AccessToken.new(self, access_token, opts)
    end
    
    # Refreshes the current Access Token
    #
    # @return [AccessToken] a new AccessToken
    # @note options should be carried over to the new AccessToken
    def refresh!(params={})
      @token = token.refresh!(params)
    end
    
    #
    # Some info
    #
    
    def user
      token.params["user"] if token
    end
    
    def user_id
      user["id"] if user
    end
    
    def scope
      token.params["scope"] if token
    end
    
    def include_scope?(scope_name)
      return true
      if token && token.params["scope"]
        token.params["scope"].split.include? scope_name
      else
        false
      end
    end
    
    def hash_for_save
      if token
        token.params.merge({"expires_in" => token.expires_in,
                            "expires_at" => token.expires_at,
                            "refresh_token" => token.refresh_token,
                            "access_token" => token.token})
      end
    end
   
    #
    # Strategies
    #
    
    # The Authorization Code strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.1
    def auth_code
      @auth_code ||= Renren2::Strategy::AuthCode.new(self)
    end
    
    # The Resource Owner Password Credentials strategy
    #
    # @see http://tools.ietf.org/html/draft-ietf-oauth-v2-15#section-4.3
    def password
      super
    end
    
    #
    # APIs
    #
    
    def admin
      @admin ||= Renren2::Interface::Admin.new(self)
    end
    
    def blog
      @blog ||= Renren2::Interface::Blog.new(self)
    end
    
    def checkins
      @checkins ||= Renren2::Interface::Checkins.new(self)
    end
    
    def feed
      @feed ||= Renren2::Interface::Feed.new(self)
    end
    
    def friends
      @friends ||= Renren2::Interface::Friends.new(self)
    end
    
    def invitations
      @invitations ||= Renren2::Interface::Invitations.new(self)
    end
    
    def like
      @like ||= Renren2::Interface::Like.new(self)
    end
    
    def notifications
      @notifications ||= Renren2::Interface::Notifications.new(self)
    end
    
    def pages
      @pages ||= Renren2::Interface::Pages.new(self)
    end
    
    def pay
      @pay ||= Renren2::Interface::Pay.new(self)
    end
    
    def photos
      @photos ||= Renren2::Interface::Photos.new(self)
    end
    
    def places
      @places ||= Renren2::Interface::Places.new(self)
    end
    
    def requests
      @requests ||= Renren2::Interface::Requests.new(self)
    end
    
    def share
      @share ||= Renren2::Interface::Share.new(self)
    end
    
    def status
      @status ||= Renren2::Interface::Status.new(self)
    end
    
    
    def users
      @users ||= Renren2::Interface::Users.new(self)
    end
  end
end
