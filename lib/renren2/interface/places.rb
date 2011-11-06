# encoding: utf-8
# test passed: 2011-11-06 16:51:21 
module Renren2
  module Interface
    
    # Places Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Places < Base
    
      # 允许用户添加一个地点
      #
      # @param [String] poi_id    用户任意传递的字符串，要求可以唯一标示一个POI（Point Of Interest），用于服务端去重，
      #                           如果传递之前传递过的poi_id，将不会创建地点，而是将上次用该poi_id创建的地点信息进行替换，
      #                           并返回上次创建地点的place_id
      # @param [String] name      地点的名称
      # @param [String] address   地点的地址
      # @param [String] longitude 地点的经度，有效范围-180.0到+180.0，“+”表示东经
      # @param [String] latitude  地点的纬度，有效范围-90.0到+90.0，“+”表示北纬
      # @param [Hash] opts 
      # @option opts [String] :zip         地点的邮政编码
      # @option opts [String] :phone       地点的联系电话，若有多个，以“，”（半角）分隔
      # @option opts [String] :country     地点所在的国家 
      # @option opts [String] :province    地点所在的省份 
      # @option opts [String] :city        地点所在的城市
      # @option opts [String] :district    地点所在的区 
      # @option opts [String] :crossstreet 地点所在的街道或交叉路口,若是交叉路口,以“&”分隔
      #
      # @see http://http://wiki.dev.renren.com/wiki/Places.create
      def create(poi_id, name, address, longitude, latitude, opts={})
        post 'places.create', :body => {:poi_id => poi_id,
                                        :name => name,
                                        :address => address,
                                        :longitude => longitude,
                                        :latitude => latitude}.merge(opts)
      end
    end
  end
end

