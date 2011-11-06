module Renren2
  module Interface
    
    # Users API
    # @see http://wiki.dev.renren.com/wiki/API
    class Users < Base
    
      #
      #
      
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getInfo
      def getInfo
      
      end
      
      # 得到当前session的用户ID
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getLoggedInUser
      def get_logged_in_user
        post 'users.getLoggedInUser'
      end
      
      #
      #
      
      #
      # @see http://wiki.dev.renren.com/wiki/Users.hasAppPermission
      def hasAppPermission
      
      end
      
      #
      #
      
      #
      # @see http://wiki.dev.renren.com/wiki/Users.isAppUser
      def isAppUser
      
      end
      
      #
      #
      
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getProfileInfo
      def getProfileInfo
      
      end
      
      #
      #
      
      #
      # @see http://wiki.dev.renren.com/wiki/Users.getVisitors
      def getVisitors
      
      end
      
    end
    
  end
end
