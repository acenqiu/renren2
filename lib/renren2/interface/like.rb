# encoding: utf-8
module Renren2
  module Interface
    
    # Like Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Like < Base
    
      # 判断用户是否喜欢过url
      #
      # @param [String] uids uid列表的JSON，上限100，结构如下所示：[8055,8066,8077]
      # @param [String] urls url列表的JSON，上限100，结构如下所示：[“http://www.docin.com/p-1141554.html”, “http://www.docin.com/p-35584072.html”]
      #
      # @see http://wiki.dev.renren.com/wiki/Like.isLiked
      def is_liked(uids, urls)
        post 'like.isLiked', :body => {:uids => uids, :urls => urls}
      end
      
      # 获取url被喜欢的次数
      #
      # @param [String] urls url列表的JSON，上限100，结构如下所示：[“http://www.docin.com/p-1141554.html”, “http://www.docin.com/p-35584072.html”]
      #
      # @see http://wiki.dev.renren.com/wiki/Like.getCount
      def get_count(urls)
        post 'like.getCount', :body => {:urls => urls}
      end
      
      # no test below
      # 对某一url执行喜欢操作
      #
      # @param [String] url 被喜欢的url
      # @note require "operate_like" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Like.like
      def like(url)
        check_scope "operate_like"
        post 'like.like', :body => {:url => url}
      end
      
      # 对某一url执行取消喜欢操作
      #
      # @param [String] url 被取消喜欢的url
      # @note require "operate_like" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Like.unlike
      def unlike(url)
        check_scope "operate_like"
        post 'like.unlike', :body => {:url => url}
      end
    end
  end
end

