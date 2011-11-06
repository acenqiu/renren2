module Renren2
  module Interface
    
    # Blog Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Blog < Base
    
      # 创建一篇日志
      #
      # @param [String] title   日志的标题
      # @param [String] content 日志的内容
      # @param [Hash] opts 
      # @option opts [int] :visible     日志的隐私设置，可用值有99(所有人可见)1(仅好友可见)4(需要密码)-1(仅自己可见),错传或没传,默认为99
      # @option opts [String] :password 用户设置的密码
      # @note require "publish_blog" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Blog.addBlog
      def add_blog(title, content, opts={})
        check_scope "publish_blog"
        post 'blog.addBlog', :body => {:title => title, :content => content}.merge(opts)
      end
      
      # 获取指定用户的可见日志信息列表
      #
      # @param [int64] uid 用户的ID
      # @param [Hash] opts 
      # @option opts [int] :page  分页的页数，默认值为1
      # @option opts [int] :count 每页显示的日志的数量, 缺省值为20
      # @note require "read_user_blog" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Blog.gets
      def gets(uid, opts={})
        check_scope "read_user_blog"
        post 'blog.gets', :body => {:uid => uid}.merge(opts)
      end
      
      # 获取自己或好友一篇日志的信息
      #
      # @param [String] id 日志id
      # @param [int64] uid 日志所有者的ID或公共主页的ID
      # @param [Hash] opts 
      # @option opts [int] :comment     返回评论内容，最大值为50，默认值0
      # @option opts [String] :password 日志的密码（当日志有密码时
      # @note require "read_user_blog" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Blog.get
      def get(id, uid, opts={})
        check_scope "read_user_blog"
        post 'blog.get', :body => {:id => id, :uid => uid}.merge(opts)
      end
      
      # 获取一篇日志的评论
      #
      # @param [String] id 日志id
      # @param [int64] uid 日志所有者的ID或公共主页的ID
      # @param [Hash] opts 
      # @option opts [int] :page  分页的页数，默认值为1
      # @option opts [int] :count 每页所包含的评论数,默认值为20, 最大值为50
      # @option opts [int] :order 排序方式。1：代表逆序；0：正序。默认值为0
      # @note require "read_user_blog,read_user_comment" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Blog.getComments
      def get_comments(id, uid, opts={})
        check_scope "read_user_blog"
        check_scope "read_user_comment"
        post 'blog.getComments', :body => {:id => id, :uid => uid}.merge(opts)
      end
      
      # 发布一个人人网日志的评论
      #
      # @param [String] id      日志id
      # @param [int64] uid      日志所有者的ID或公共主页的ID
      # @param [String] content 评论的内容
      # @param [Hash] opts
      # @option opts [int] :rid  用于二级回复，被回复的人的用户ID
      # @option opts [int] :type 是否为悄悄话，1表示悄悄话，0表示公开评论
      # @note require "publish_blog,publish_comment" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Blog.addComment
      def add_comment(id, uid, content, opts={})
        check_scope "publish_blog"
        check_scope "publish_comment"
        post 'blog.addComment', :body => {:id => id, :uid => uid, :content => content}.merge(opts)
      end
    end
  end
end

