# encoding: utf-8
module Renren2
  module Interface
    
    # Notifications Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Notifications < Base
    
      # test failed: to_ids set to nil, failed..
      # 给当前登录者的好友或也安装了同样应用的用户发通知
      #
      # @param [String] to_ids 用户id的列表，单个或多个，可以是逗号分隔，如 8055,8066,8077。这些用户必须是当前登录者的好友或也安装了此应用。	
      #                        请确保一次传入的用户id数少于20个。如果要给当前用户发送通知，请指定此参数值为空串。
      # @param [String] notification 通知的内容，可以是XNML类型的文本信息，支持的XNML有<xn:name/>和<a/>，
      #                              请注意：使用<xn:name/>标签的时候，其uid属性值只能是真实的用户id（阿拉伯数字）。
      #
      # @see http://wiki.dev.renren.com/wiki/Notifications.send
      def send(to_ids, notification)
        post 'notifications.send', :body => {:to_ids => to_ids, :notification => notification}
      end
      
      # no test
      # 给你的用户发送Email
      #
      # @param [int] template_id      邮件模板的ID
      # @param [String] recipients    收件人的UID，多个ID用逗号隔开，例如：2838234,2342312. 一次最多100个ID
      # @param [String] template_data JSON对象，渲染邮件模板所需要的数据。例如：{"who":"234234","static_uid":"23423423"}
      # @param [Hash] opts 
      # @option opts [int] :uid 用户的ID
      # @note require "email" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Notifications.sendEmail
      # @see http://wiki.dev.renren.com/wiki/HowToSendEmail
      def send_email(template_id, recipients, template_data, opts={})  
        check_scope "email"
        post 'notifications.sendEmail', :body => {:template_id => template_id, 
                                                  :recipients => recipients, 
                                                  :template_data => template_data}.merge(opts)
      end
    end
  end
end

