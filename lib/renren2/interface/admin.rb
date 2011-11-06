# encoding: utf-8
# test passed: 2011-11-06 14:50:22 
module Renren2
  module Interface
    
    # Admin Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Admin < Base
    
      # 得到一个应用当天可以发送的通知和邀请的配额
      #
      # @see http://wiki.dev.renren.com/wiki/Admin.getAllocation
      def get_allocation
        post 'admin.getAllocation'
      end
      
      # 对给定的文本进行过滤，返回过滤后的文本，如果不合法，则给出错误信息
      #
      # @param [String] text 需检查的文本内容
      # @param [Hash] opts 
      # @option opts [int] :type 过滤的文本类型，１代表纯文本，2代表包含脚本或标签的文本。缺省值为1
      #
      # @see http://wiki.dev.renren.com/wiki/Admin.textFilter
      def text_filter(text, opts={})
        post 'admin.textFilter', :body => {:text => text}.merge(opts)
      end
    
    end
  end
end

