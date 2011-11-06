module Renren2
  module Interface
    
    # Status API
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Status < Base
      
      #
      #
      
      #
      # @see http://http://wiki.dev.renren.com/wiki/Status.gets
      def gets
      
      end
      
      # 用户更新状态
      #
      # @param [String] status 用户更新的状态信息，最多140个字符
      # @param [Hash] opts 
      # @option opts [String] :place_id 发状态时所在地点的ID
      # @note require "status_update" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Status.set
      def set(status, opts={})
        post 'status.set', :body => {:status => status}.merge(opts)
      end
      
      #
      #
      
      #
      # @see http://http://wiki.dev.renren.com/wiki/Status.get
      def get
      
      end
      
      #
      #
      
      #
      # @see http://http://wiki.dev.renren.com/wiki/Status.getComment
      def getComment
      
      end
      
      #
      #
      
      #
      # @see http://http://wiki.dev.renren.com/wiki/Status.addComment
      def addComment
      
      end
      
      #
      #
      
      #
      # @see http://http://wiki.dev.renren.com/wiki/Status.getEmotions
      def getEmotions
      
      end
      
      #
      #
      
      #
      # @see http://http://wiki.dev.renren.com/wiki/Status.forward
      def forward
      
      end
      
    end
    
  end
end
