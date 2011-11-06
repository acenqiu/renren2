# encoding: utf-8
# test passed: 2011-11-06 15:39:14 
module Renren2
  module Interface
    
    # Invitations Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Invitations < Base
    
      # 生成用户站外邀请用户注册的链接地址,应用可以引导用户通过QQ或者msn等渠道邀请好友加入应用
      #
      # @param [Hash] opts 
      # @option opts [int] :domain 获取邀请链接地址的域名属性，0表示人人(wwv.renren.com)，1表示开心(wwv.kaixin.com)，默认值为人人
      #
      # @see http://wiki.dev.renren.com/wiki/Invitations.createLink
      def create_link(opts={})
        post 'invitations.createLink', :body => opts
      end
      
      # 根据应用新用户的id获取用户是否通过邀请安装，同时得到此次邀请的详细信息（包括邀请者、邀请时间、被邀请者等）
      #
      # @param [Hash] opts 
      # @option opts [String] :invitee_id 被邀请者的用户ID
      # @option opts [String] :inviter_id 邀请者的ID
      # @option opts [String] :begin_time 查询起始时间，格式为：yyyy-MM-dd HH:mm:ss
      # @option opts [String] :end_time   查询结束时间，格式为：yyyy-MM-dd HH:mm:ss
      # @option opts [int] :page          分页的页数，默认值为1
      # @option opts [int] :count         分页后每页的数量，默认值为100
      # @note 1.如果想获得某个用户被谁邀请进来的，请传入invitee_id
      #       2.如果想获得一段时间内所有用户的邀请信息，请传入begin_time和end_time，此时请不要传入invitee_id
      #
      # @see http://wiki.dev.renren.com/wiki/Invitations.getInfo
      def get_info(opts={})
        post 'invitations.getInfo', :body => opts
      end
    end
  end
end

