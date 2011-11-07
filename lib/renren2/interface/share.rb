# encoding: utf-8
module Renren2
  module Interface
    
    # Share Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Share < Base
    
      # 发布分享，例如分享视频、音乐、链接、日志、相册、照片等
      #
      # @param [int] type 分享的类型：日志为1、照片为2、链接为6、相册为8、视频为10、音频为11、分享为20
      # @param [Hash] opts 
      # @option opts [int] :ugc_id  分享人人网站内内容的ID。如日志、照片、相册、分享的ID
      # @option opts [int] :user_id 分享人人网站内内容所有者的ID。如日志、照片、相册、分享所有者的用户ID
      # @option opts [String] :url  分享人人网站外内容的URL
      # @option opts [String] :comment 分享内容时，用户的评论内容
      # @note require "publish_share" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Share.share
      def share(type, opts={})
        check_scope "publish_share"
        post 'share.share', :body => {:type => type}.merge(opts)
      end
      
      # 获取某个分享的评论
      #
      # @param [int] user_id  分享所有者的ID
      # @param [int] share_id 所要取得评论的分享的ID
      # @note require "read_user_share、read_user_comment" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Share.getComments
      def get_comments(user_id, share_id)
        check_scope "read_user_share"
        check_scope "read_user_comment"
        post 'share.getComments', :body => {:user_id => user_id, :share_id => share_id}
      end
      
      # 对某个分享进行评论
      #
      # @param [int] share_id   被回复分享的ID
      # @param [int] user_id    被回复分享所有者的用户ID
      # @param [String] content 回复的内容 
      # @param [Hash] opts 
      # @option opts [int] :to_user_id 被回复用户的ID
      # @note require "publish_comment、publish_share" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Share.addComment
      def add_comment(share_id, user_id, content, opts={})
        check_scope "publish_comment"
        check_scope "publish_share"
        post 'share.addComment', :body => {:share_id => share_id, :user_id => user_id, :content => content}.merge(opts)
      end
    
    end
  end
end

