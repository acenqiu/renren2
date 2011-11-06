module Renren2
  module Interface
    
    # Requests Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Requests < Base
    
      # 获取当前用户的圈人请求列表，在调用之前，应用必须获取到用户的授权
      #
      # @param [Hash] opts 
      # @option opts [int] :page  支持分页，指定页号，页号从1开始，默认值为1
      # @option opts [int] :count 支持分页，每一页记录数，默认值为20
      # @note require "read_user_request" scope
      #
      # @see http://http://wiki.dev.renren.com/wiki/Requests.getTagRequests
      def get_tag_requests(opts={})
        check_scope "read_user_request"
        post 'requests.getTagRequests', :body => opts
      end
    
    end
  end
end

