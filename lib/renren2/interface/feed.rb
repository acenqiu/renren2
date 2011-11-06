# encoding: utf-8
# test passed: 2011-11-06 14:49:26 
module Renren2
  module Interface
    
    # Feed Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Feed < Base
    
      # 获取当前用户的新鲜事内容
      #
      # @param [String] type 新鲜事的类别，多个类型以逗号分隔(http://wiki.dev.renren.com/wiki/Type%E5%88%97%E8%A1%A8)
      # @param [Hash] opts
      # @option opts [int] :uid   支持传入当前用户的一个好友ID,表示获取此好友的新鲜事，如果不传，默认为获取当前用户的新鲜事
      # @option opts [int] :page  支持分页，指定页号，页号从1开始，默认值为1
      # @option opts [int] :count 支持分页，每一页记录数，默认值为30，最大50
      # @note require "read_user_feed" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Feed.get
      def get(type, opts={})
        check_scope "read_user_feed"
        post 'feed.get', :body => {:type => type}.merge(opts)
      end
      
      # 以当前会话的用户（session_key对应用户）身份发送应用的自定义新鲜事
      #
      # @param [String] name        新鲜事标题 注意：最多30个字符
      # @param [String] description 新鲜事主体内容 注意：最多200个字符
      # @param [String] url         新鲜事标题和图片指向的链接
      # @option opts [String] :image       新鲜事图片地址
      # @option opts [String] :caption     新鲜事副标题 注意：最多20个字符
      # @option opts [String] :action_name 新鲜事动作模块文案。 注意：最多10个字符
      # @option opts [String] :action_link 新鲜事动作模块链接
      # @option opts [String] :message     用户输入的自定义内容。注意：最多200个字符
      # @note require "publish_feed" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Feed.publishFeed
      def publish_feed(name, description, url, opts={})
        check_scope "publish_feed"
        post 'feed.publishFeed', :body => {:name => name, :description => description, :url => url}.merge(opts)
      end
      
    end
  end
end

