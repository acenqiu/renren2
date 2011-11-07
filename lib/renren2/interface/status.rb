module Renren2
  module Interface
    
    # Status API
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Status < Base
      
      # 返回指定用户的状态列表，不包含回复内容。如果不指定用户，则获取当前用户的状态信息
      #
      # @param [Hash] opts 
      # @option opts [int] :uid   状态信息所属用户id，不指定则判断为当前用户
      # @option opts [int] :page  支持分页，指定页号，页号从1开始。缺省返回第一页数据
      # @option opts [int] :count 支持分页，指定每页记录数，缺省为每页10条记录。最大不能超过1000
      # @note require "read_user_status" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Status.gets
      def gets(opts={})
        check_scope "read_user_status"
        post 'status.gets', :body => opts
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
        check_scope "status_update"
        post 'status.set', :body => {:status => status}.merge(opts)
      end
      
      # 返回用户某条状态，不包含回复内容
      #
      # @param [int64] status_id 状态的id,如果未指定状态id则返回当前用户最新的状态
      # @param [Hash] opts 
      # @option opts [int64] :owner_id 状态信息所属用户id，不指定则为当前用户
      # @note require "read_user_status" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Status.get
      def get(status_id, opts={})
        check_scope "read_user_status"
        post 'status.get', :body => {:status_id => status_id}.merge(opts)
      end
      
      # 获取一条状态中的所有最新回复内容
      #
      # @param [int64] status_id 状态的id
      # @param [int] owner_id    状态所有者的id
      # @param [Hash] opts 
      # @option opts [int] :page  支持分页，指定页号，页号从1开始。缺省返回第一页数据
      # @option opts [int] :count 支持分页，指定每页记录数，缺省为每页10条记录
      # @option opts [int] :order 获取留言的排序规则，0表示升序(最旧到新)，1表示降序(最新到旧)，默认为0
      # @note require "read_user_status" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Status.getComment
      def get_comment(status_id, owner_id, opts={})
        check_scope "read_user_status"
        post 'status.getComment', :body => {:status_id => status_id, :owner_id => owner_id}.merge(opts)
      end
      
      # no test
      # 对一条状态增加一条回复
      #
      # @param [int] owner_id    状态所有者的id
      # @param [String] content  回复的内容 
      # @param [int64] status_id 状态的id
      # @param [Hash] opts 
      # @option opts [int64] :rid 被回复的用户的ID，如果是直接回复某条状态，此参数不用传
      # @note require "read_user_status,publish_comment" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Status.addComment
      def add_comment(owner_id, content, status_id, opts={})
        check_scope "read_user_status"
        check_scope "publish_comment"
        post 'status.addComment', :body => {:owner_id => owner_id, :content => content, :status_id => status_id}.merge(opts)
      end
      
      # 获取状态中的表情图片和表情符号对应列表
      #
      # @param [Hash] opts 
      # @option opts [String] :type 获取列表的类型，type为all返回全部数据，type为recent返回网页同步数据，默认网页同步数据
      #
      # @see http://wiki.dev.renren.com/wiki/Status.getEmoticons
      def get_emoticons(opts={})
        post 'status.getEmoticons', :body => opts
      end
      
      # 用户转发状态的操作，支持同时评论给转发人
      #
      # @param [String] status     用户更新的状态信息，与转发前的内容加在一起最多140个字符
      # @param [int64] forward_id  被转发的状态id
      # @param [int] forward_owner 被转发的状态所有者的id
      # @note require "status_update" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Status.forward
      def forward(status, forward_id, forward_owner)
        check_scope "status_update"
        post 'status.forward', :body => {:status => status, :forward_id => forward_id, :forward_owner => forward_owner}
      end
      
    end
    
  end
end
