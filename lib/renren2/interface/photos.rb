module Renren2
  module Interface
    
    # Photos Interface
    #
    # @see http://wiki.dev.renren.com/wiki/API
    class Photos < Base
    
      # 以人人用户的身份创建相册
      #
      # @param [String] name 相册的名字
      # @param [Hash] opts 
      # @option opts [String] :location    相册的地点 
      # @option opts [String] :description 相册的描述
      # @option opts [String] :visible     相册的隐私设置. owner（自己）、friends（好友）、 networks（网络）、everyone(所有人)。
      #                                    99(所有人),1(好友), 3(同网络人), -1(仅自己可见)
      # @option opts [String] :password    相册的密码，支持字母，数字，符号，限16个字符
      # @note require "create_album" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.createAlbum
      def create_album(name, opts={})
        check_scope "create_album"
        post 'photos.createAlbum', :body => {:name => name}.merge(opts)
      end
      
      # 获取用户的相册列表信息。当取第一页时，会返回头像相册和快速上传相册
      #
      # @param [int] uid 相册所有者的用户ID
      # @param [Hash] opts 
      # @option opts [int] :page    分页的页数，默认值为1
      # @option opts [int] :count   分页后每页的个数，默认值为10
      # @option opts [String] :aids 多个相册的ID，以逗号分隔，最多支持10个数据
      # @note require "read_user_album" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.getAlbums
      def get_albums(uid, opts={})
        check_scope "read_user_album"
        post 'photos.getAlbums', :body => {:uid => uid}.merge(opts)
      end
      
      # 上传照片到用户的相册，同时返回这张照片的信息
      #
      # @param [String] upload          待上传照片路径
      # @param [String] content_type    待上传照片格式
      # @param [Hash] opts 
      # @option opts [String] :caption  照片的描述信息
      # @option opts [int] :aid         相册的ID，如果指定此参数，将会传到指定相册，默认传到手机相册 
      # @option opts [String] :place_id 上传照片所在地点的ID
      # @note require "photo_upload" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.upload
      def upload(upload, content_type, opts={})
        check_scope "photo_upload"
        post 'photos.upload', :body => {:upload => Faraday::UploadIO.new(upload, content_type)}.merge(opts)
      end
      
      # 获取可见照片的相关信息
      #
      # @param [int] uid 照片所有者的用户ID或公共主页的ID
      # @param [Hash] opts 
      # @option opts [int64] :aid       相册的id。aid和pids至少传递一个
      # @option opts [String] :password 加密相册的密码
      # @option opts [int] :page        页码，默认值为1
      # @option opts [int] :count       每页的容量，默认值为10，必须大于0，小于200
      # @option opts [String] :pids     照片id串，以分","割，最多20个
      # @note require "read_user_photo" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.get
      def get(uid, opts={})
        check_scope "read_user_photo"
        post 'photos.get', :body => {:uid => uid}.merge(opts)
      end
      
      # 对可见照片或者相册进行评论
      #
      # @param [int] uid        照片或相册所有者的用户ID
      # @param [String] content 评论的内容，最多140字
      # @param [Hash] opts 
      # @option opts [int64] :aid  相册的id。aid和pid至少传递一个
      # @option opts [String] :pid 照片id。aid和pid至少传递一个
      # @option opts [int64] :rid  评论的用户id，如果想对评论中的评论进行二级回复需要传递此参数
      # @option opts [int] :type   评论的类型，是否为悄悄话，1表示悄悄话，0表示非悄悄话，默认为0
      # @note require "read_user_photo，publish_comment" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.addComment
      def add_comment(uid, content, opts={})
        check_scope "read_user_photo"
        check_scope "publish_comment"
        post 'photos.addComment', :body => {:uid => uid, :content => content}.merge(opts)
      end
      
      # 获取可见照片的相关评论内容
      #
      # @param [int] uid 照片或相册所有者的用户ID
      # @param [Hash] opts 
      # @option opts [int64] :aid  相册的id。aid和pid至少传递一个
      # @option opts [String] :pid 照片id。aid和pid至少传递一个
      # @option opts [int] :page   支持分页，缺省值为1（第一页）
      # @option opts [int] :count  每页的数量，缺省值为10
      # @note require "read_user_photo，read_user_comment" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.getComments
      def get_comments(uid, opts={})
        check_scope "read_user_photo"
        check_scope "read_user_comment"
        post 'photos.getComments', :body => {:uid => uid}.merge(opts)
      end
      
      # 圈出照片中的好友或人
      #
      # @param [int] photo_id     照片的ID
      # @param [int] owner_id     照片所有者的ID
      # @param [int] photo_width  照片的宽度，以像素为单位。由于photos.get没有下发照片的宽和高，需要开发者自行计算图片的宽和高
      # @param [int] photo_height 照片的高度，以像素为单位
      # @param [int] top          圈人框距照片上端的距离，以像素为单位
      # @param [int] left         圈人框距照片左端的距离，以像素为单位
      # @param [int] frame_width  圈人框的宽度，以像素为单位
      # @param [int] frame_height 圈人框的高度，以像素为单位
      # @param [Hash] opts 
      # @option opts [int] :tagged_user_id      被圈用户的ID，该ID对应用户必须与session_key对应用户为好友关系
      # @option opts [String] :tagged_user_name 被圈用户的名字，若被圈的人没有人人用户ID时，可以传递user_name参数
      # @note require "send_request" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.tag
      def tag(photo_id, owner_id, photo_width, photo_height, top, left, frame_width, frame_height, opts={})
        check_scope "send_request"
        post 'photos.tag', :body => {:photo_id => photo_id,
                                     :owner_id => owner_id,
                                     :photo_width => photo_width,
                                     :photo_height => photo_height,
                                     :top => top,
                                     :left => left,
                                     :frame_width => frame_width,
                                     :frame_height => frame_height}.merge(opts)
      end
      
      # 获取照片中圈出的好友或人
      #
      # @param [int] photo_id 照片的ID
      # @param [int] owner_id 照片所有者的ID
      # @param [Hash] opts 
      # @option opts [int] :page  页码。默认值为1
      # @option opts [int] :count 每页个数。默认为100，必须大于0，小于200
      # @note require "read_user_photo" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.getTags
      def get_tags(photo_id, owner_id, opts={})
        check_scope "read_user_photo"
        post 'photos.getTags', :body => {:photo_id => photo_id, :owner_id => owner_id}.merge(opts)
      end
      
      # 接受圈人请求
      #
      # @param [int] tag_id         圈人（Tag）的ID
      # @param [int] photo_owner_id 圈人（Tag）所在照片所有者的ID
      # @note require "deal_request" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.acceptTag
      def accept_tag(tag_id, photo_owner_id)
        check_scope "deal_request"
        post 'photos.acceptTag', :body => {:tag_id => tag_id, :photo_owner_id => photo_owner_id}
      end
      
      # 拒绝接受圈人请求
      #
      # @param [int] tag_id         圈人（Tag）的ID
      # @param [int] photo_owner_id 圈人（Tag）所在照片所有者的ID
      # @note require "deal_request" scope
      #
      # @see http://wiki.dev.renren.com/wiki/Photos.refuseTag
      def refuse_tag(tag_id, photo_owner_id)
        check_scope "deal_request"
        post 'photos.refuseTag', :body => {:tag_id => tag_id, :photo_owner_id => photo_owner_id}
      end
      
    end
  end
end

