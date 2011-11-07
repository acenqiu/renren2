# encoding: utf-8
# test passed: 2011-11-07 15:50:40 
module Renren2
  module Interface
    
    # Users API
    # @see http://wiki.dev.renren.com/wiki/API
    class Users < Base
    
      # 获取用户的信息
      #
      # @param [Hash] opts 
      # @option opts [String] :uids   需要查询的用户的ID，多个ID用逗号隔开。当此参数为空时，返回当前用户
      # @option opts [String] :fields 返回的字段列表，可以指定返回那些字段，用逗号分隔
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getInfo
      def get_info(opts={})
        post 'users.getInfo', :body => opts
      end
      
      # 得到当前session的用户ID
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getLoggedInUser
      def get_logged_in_user
        post 'users.getLoggedInUser'
      end
      
      # 检查用户是否授予应用扩展权限
      #
      # @param [String] ext_perm 用户可操作的扩展授权，例如email
      #
      # @see http://wiki.dev.renren.com/wiki/Users.hasAppPermission
      def has_app_permission(ext_perm)
        post 'users.hasAppPermission', :body => {:ext_perm => ext_perm}
      end
          
      # 获取用户个人主页的信息，包括日志数、好友数、相册数、个人基本资料等
      #
      # @param [int] uid 个人主页用户的ID
      # @param [Hash] opts 
      # @option opts [String] :fields 需要获取的信息的字段列表，各个字段用逗号隔开
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getProfileInfo
      def get_profile_info(uid, opts={})
        post 'users.getProfileInfo', :body => {:uid => uid}.merge(opts)
      end
      
      # 获得当前用户最近来访的列表
      #
      # @param [Hash] opts 
      # @option opts [int] :page  支持分页，指定页号，页号从1开始
      # @option opts [int] :count 支持分页，指定每页记录数，缺省值为6
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getVisitors
      def get_visitors(opts={})
        post 'users.getVisitors', :body => opts
      end
      
    end
    
  end
end
