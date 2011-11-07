# encoding: utf-8
# test passed: 2011-11-07 21:23:56 
module Renren2
  module Interface
    
    # Pages Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Pages < Base
    
      # 获取当前用户管理的Page列表
      #
      # @param [Hash] opts 
      # @option opts [int] :page  页码，默认值为1
      # @option opts [int] :count 每页的容量，默认值为10
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.getManagedList
      def get_managed_list(opts={})
        post 'pages.getManagedList', :body => opts
      end
      
      # 成为某个Page的粉丝
      #
      # @param [int] page_id Page的ID
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.becomeFan
      def become_fan(page_id)
        post 'pages.becomeFan', :body => {:page_id => page_id}
      end
      
      # 与某个公共主页解除粉丝关系
      #
      # @param [int] page_id Page的ID
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.quit
      def quit(page_id)
        post 'pages.quit', :body => {:page_id => page_id}
      end
      
      # Page管理员修改Page的状态
      #
      # @param [String] status 管理员更新的page状态信息，最多140个字符
      # @param [int] page_id   Page的ID
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.setStatus
      def set_status(status, page_id)
        post 'pages.setStatus', :body => {:status => status, :page_id => page_id}
      end
      
      # 判断用户是否为Page的粉丝
      #
      # @param [Hash] opts 
      # @option opts [int] :uid     用户的ID
      # @option opts [int] :page_id Page的ID，缺省时，值为当前应用对应的Page的ID
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.isFan
      def is_fan(opts={})
        post 'pages.isFan', :body => opts
      end
      
      # 获取公共主页的类型
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.getCategories
      def get_categories
        post 'pages.getCategories'
      end
      
      # 获取某个Page的信息
      #
      # @param [int] page_id   Page的ID
      # @param [String] fields 需要返回的字段的列表，多个字段间用逗号隔开。现在支持：status(当前状态),desc(描述),
      #                        base_info(基本信息),albums_count(相册总数),blogs_count(日志总数), fans_count(粉丝总数),
      #                        detail_info(详细信息), contact_info(联系信息)
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.getInfo
      def get_info(page_id, fields)
        post 'pages.getInfo', :body => {:page_id => page_id, :fields => fields}
      end
      
      # 判断当前用户是否是某个Page的管理员
      #
      # @param [int] page_id Page的ID
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.isAdmin
      def is_admin(page_id)
        post 'pages.isAdmin', :body => {:page_id => page_id}
      end
      
      # 判断一个ID是否为Page
      # 
      # @param [int] page_id Page的ID
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.isPage
      def is_page(page_id)
        post 'pages.isPage', :body => {:page_id => page_id}
      end
      
      # 获取Page的列表
      # 
      # @param [Hash] opts 
      # @option opts [int] :uid      用户的ID。当此参数不为空时表示获取此人关注的公共主页列表
      # @option opts [int] :page     页码，默认值为1
      # @option opts [int] :count    每页的容量，默认值为10 
      # @option opts [int] :category 分类的ID。缺省时表示获取所有类型的公共主页
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.getList
      def get_list(opts={})
        post 'pages.getList', :body => opts
      end
      
      # 获取Page粉丝的列表
      #
      # @param [int] page_id Page的ID
      # @param [Hash] opts 
      # @option opts [int] :page  分页显示的页码 缺省值为1
      # @option opts [int] :count 每页显示的粉丝的数量, 缺省值为10
      #
      # @see http://wiki.dev.renren.com/wiki/Pages.getFansList
      def get_fans_list(page_id, opts={})
        post 'pages.getFansList', :body => {:page_id => page_id}.merge(opts)
      end
    
    end
  end
end

