module Renren2
  module Interface
    
    # Checkins Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Checkins < Base
    
      # 签到
      #
      # @param [String] place_id 签到地点的ID
      # @param [Hash] opts
      # @option opts [String] :message   签到时发布的内容
      # @option opts [double] :longitude 地点的经度，有效范围-180.0到+180.0，“+”表示东经
      # @option opts [double] :latitude  地点的纬度，有效范围-90.0到+90.0，“+”表示北纬
      # @option opts [int] :privacy      隐私设置。“0”表示所有人可见,“1”仅自己可见。默认“0”为所有人可见
      # @note require "publish_checkin" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Checkins.checkin
      def checkin(place_id, opts={})
        check_scope "publish_checkin"
        post 'checkins.checkin', :body => {:place_id => place_id}.merge(opts)
      end
    end
  end
end

