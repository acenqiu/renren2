# encoding: utf-8
# test passed: 2011-11-06 15:22:49 
module Renren2
  module Interface
    
    # Friends Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Friends < Base
    
      # 判断两组用户是否互为好友关系，比较的两组用户数必须相等
      #
      # @param [String] uids1 第一组用户的ID，每个ID之间以逗号分隔
      # @param [String] uids2 第二组用户的ID，每个ID之间以逗号分隔
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.areFriends
      def are_friends(uids1, uids2)
        post 'friends.areFriends', :body => {:uids1 => uids1, :uids2 => uids2}
      end
      
      # 得到当前登录用户的好友列表，得到的只是含有好友uid的列表
      #
      # @param [Hash] opts 
      # @option opts [int] :page  分页，默认为1
      # @option opts [int] :count 返回每页个数，默认为500
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.get
      def get
        post 'friends.get'
      end
      
      # 获取两个用户的共同好友
      #
      # @param [int] uid1 用户1
      # @param [int] uid2 用户2
      # @param [Hash] opts 
      # @option opts [String] :fields 好友属性列表（逗号分隔）。支持的值有：uid,name,sex,tinyurl,headurl,mainurl。 缺省：uid
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.getSameFriends
      def get_same_friends(uid1, uid2, opts={})
        post 'friends.getSameFriends', :body => {:uid1 => uid1, :uid2 => uid2}.merge(opts)
      end
      
      # 得到当前登录用户的好友列表
      #
      # @param [Hash] opts 
      # @option opts [int] :page      分页，默认为1
      # @option opts [int] :count     返回每页个数，默认为500
      # @option opts [String] :fields 需要返回的字段，多个字段用逗号(,)隔开。目前支持如下字段: headurl_with_logo, tinyurl_with_logo
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.getFriends
      def get_friends(opts={})
        post 'friends.getFriends', :body => opts
      end
      
      # 返回已经添加了一个应用的好友的用户Id列表，此接口只返回全部好友中的数据
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.getAppUsers
      def get_app_users
        post 'friends.getAppUsers'
      end
      
      # 返回App好友的ID列表
      #
      # @param [Hash] opts 
      # @option opts [String] :fields 返回的字段列表，可以指定返回那些字段，用逗号分隔。
      #           目前支持name（姓名）、tinyurl(小头像)、headurl（中等头像），如果不传递此参数，默认返回好友id节点
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.getAppFriends
      def get_app_friends(opts={})
        post 'friends.getAppFriends', :body => opts
      end
      
      # 搜索用户，根据搜索条件返回搜索结果
      #
      # @param [String] name 搜索姓名
      # @param [Hash] opts 
      # @option opts [String] :condition 查询条件。
      #           json格式如：[{"t":"base","gend":"男生","prov":"天津"},{"t":"high","year":"2000"},{"t":"univ","name":"东北大学"}]
      #           "t"搜索条件类型，各个类型包含的条件如下：
      #             1. "t":"base" 基本信息，"gend" 性别，"prov" 省份，"city" 城市
      #             2. "t":"univ" 大学，   "name" 大学名称，"id" 大学的id见主站，"depa" 学院，"year" 入学年份
      #             3. "t":"high" 高中，   "name" 高中名称，"year" 入学年份
      #             4. "t":"sect" 中专技校，"name" 名称，   "year" 入学年份
      #             5. "t":"juni" 初中，   "name" 初中名称，"year" 入学年份
      #             6. "t":"elem" 小学，   "name" 小学称，  "year" 入学年份
      #             7. "t":"birt" 生日，   "year" 年，     "month" 月， "day" 日， "astr" 星座
      #             8. "t":"work" 公司，   "name" 公司名称
      # @option opts [int] :page  分页显示的页码 缺省值为1
      # @option opts [int] :count 每页显示的日志的数量, 缺省值为20
      #
      # @see http://wiki.dev.renren.com/wiki/Friends.search
      def search(name, opts={})
        post 'friends.search', :body => {:name => name}.merge(opts)
      end
      
    end
  end
end

