module Renren2
  module Interface
  
    # The Base class of API
    class Base
      def initialize(client)
        @client = client
      end
      
      def check_scope(scope_name)
        unless @client.include_scope? scope_name
          raise "You haven't got the scope " + scope_name
        end
      end
      
      def request(verb, path, opts={}, &block)
        unless @client.is_authorized?
          raise "I can't find a valid access_token. Forgot to get it or expired?"
        end
        
        # Note that it is a hack here. Renren hasn't started using http://graph.renren.com as its api server, so
        # we still use http://api.renren.com/restserver.do as a temporary solution. And the :path param will act 
        # as the :method params in querystring.
        params = {:access_token => @client.token.token,
                  :method       => path,
                  :v            => "1.0",
                  :format       => "JSON"}.merge(opts.delete(:body) || {})
                                          .merge(opts.delete(:params) || {})
        opts.merge!(:body => params.merge(:sig => compute_sig(params)), :parse => :json)
        
        # use the old server
        path = "http://api.renren.com/restserver.do"
        
        @client.token.request(verb, path, opts, &block)
      end
      
      def get(path, opts={}, &block)
        request(:get, path, opts, &block)
      end
      
      def post(path, opts={}, &block)
        request(:post, path, opts, &block)
      end
      
      private
      
        def compute_sig(params={})
          params = params.reject {|k,v| v.class == Faraday::UploadIO }
          str = params.collect {|k,v| "#{k}=#{v}"}.sort.join("") + @client.secret
          Digest::MD5.hexdigest(str)
        end
    end
    
  end
end
