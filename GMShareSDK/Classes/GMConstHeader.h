//
//  GMConstHeader.h
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#ifndef GMConstHeader_h
#define GMConstHeader_h

//国美平台分享类型
typedef NS_ENUM(NSUInteger, GMSharePlatformType) {
    GMSocialPlatformType_WechatSession = 1, //微信聊天
    GMSocialPlatformType_WechatTimeLine = 2,//微信朋友圈
    GMSocialPlatformType_WechatFavorite =3, //收藏
};

typedef NS_ENUM(NSUInteger, GMShareContentType) {
    GMShareContentTypeImage = 1, //图片分享
    GMShareContentTypeText, //文本分享
    GMShareContentTypeWebPage, //网页分享
    GMShareContentTypeImages,//多图分享
    GMContentTypeMiniProgram //小程序 分享
};

typedef NS_ENUM(NSInteger, GMShareWXMiniProgramType) {
    GMShareWXMiniProgramTypeRelease = 0,       //**< 正式版  */
    GMShareWXMiniProgramTypeTest = 1,        //**< 开发版  */
    GMShareWXMiniProgramTypePreview = 2,         //**< 体验版  */
};


#endif /* GMConstHeader_h */
