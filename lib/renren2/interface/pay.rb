# encoding: utf-8
module Renren2
  module Interface
    
    # Pay Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Pay < Base
    
      # 查询某个用户在一个应用中一次消费是否完成
      #
      # @param [int64] order_id 用户消费校内豆订单号
      #
      # @see http://wiki.dev.renren.com/wiki/Pay.isCompleted
      def is_completed(order_id)
        post 'pay.isCompleted', :body => {:order_id => order_id}
      end
      
      # 预存入用户在应用中消费产生的订单数据，消费数额等信息
      #
      # @param [int64] order_id     用户消费校内豆订单号，参数必须保证唯一，每一次不能传递相同的参数
      # @option opts [int] :amount  校内豆消费数额, 取值范围为[0,1000]
      # @option opts [String] :desc 用户使用校内豆购买的虚拟物品的名称
      # @param [Hash] opts 
      # @option opts [int] :type 0代表WEB支付订单，1代表WAP支付订单，默认值为0
      #
      # @see http://wiki.dev.renren.com/wiki/Pay.regOrder
      def reg_order(order_id, amount, desc, opts={})
        post 'pay.regOrder', :body => {:order_id => order_id, :amount => amount, :desc => desc}.merge(opts)
      end
      
      # 根据订单号查询订单，支持批量查询
      #
      # @param [String] order_numbers 订单号，多个订单用逗号隔开
      #
      # @see http://wiki.dev.renren.com/wiki/Pay.queryOrders
      def query_orders(order_numbers)
        post 'pay.queryOrders', :body => {:order_numbers => order_numbers}      
      end
      
      # 查询某个用户在一个应用中一次消费是否完成
      #
      # @param [int64] order_id 用户消费校内豆订单号
      #
      # @see http://wiki.dev.renren.com/wiki/Pay4Test.isCompleted
      def test_is_completed(order_id)
        post 'pay4Test.isCompleted', :body => {:order_id => order_id}
      end
      
      # 预存入用户在应用中消费产生的订单数据，消费数额等信息
      #
      # @param [int64] order_id     用户消费校内豆订单号，参数必须保证唯一，每一次不能传递相同的参数
      # @option opts [int] :amount  校内豆消费数额, 取值范围为[0,1000]
      # @option opts [String] :desc 用户使用校内豆购买的虚拟物品的名称
      # @param [Hash] opts 
      # @option opts [int] :type 0代表WEB支付订单，1代表WAP支付订单，默认值为0
      #
      # @see http://wiki.dev.renren.com/wiki/Pay4Test.regOrder
      def test_reg_order(order_id, amount, desc, opts={})
        post 'pay4Test.regOrder', :body => {:order_id => order_id, :amount => amount, :desc => desc}.merge(opts)
      end
      
    end
  end
end

