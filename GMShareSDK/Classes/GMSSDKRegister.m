//
//  GMSSDKRegister.m
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import "GMSSDKRegister.h"
#import "WXApi.h"
#import <UMShare/UMShare.h>
#import <pthread.h>
#import "GMPlatformModel.h"


@interface GMSSDKRegister ()
@property(nonatomic,strong)NSMutableArray  * platforms;

@end


@implementation GMSSDKRegister{
    
    pthread_mutex_t _lock;
}

-(instancetype)init{
    
    if (self=[super init]) {
       pthread_mutex_init(&_lock, NULL);
    }
    return self;
}

-(void)dealloc{
    
    pthread_mutex_destroy(&_lock);
}

-(NSMutableArray *)platforms{
    if (!_platforms) {
        _platforms = [NSMutableArray array];
    }
    return _platforms;
}

-(NSArray *)platformsInfo{
    return _platforms;
}

/*QQ注册平台*/
-(void)setupWeChatWithAppId:(NSString*)appKey appSecret:(NSString*)appSecret{
    
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:appKey  appSecret:appSecret redirectURL:nil];
    
    NSArray * qq = @[
          @{
              @"platform_name":@"微信好友",
              @"icon_image":@"Group_wechatSession",
              @"plat_tag":@(UMSocialPlatformType_WechatSession)
                      },
                       @{
              @"platform_name":@"朋友圈",
              @"icon_image":@"Group_wechatTimeLine",
              @"plat_tag":@(UMSocialPlatformType_WechatSession)
                       }];
    
        [self addPlatformInfo:[GMPlatformModel mj_objectArrayWithKeyValuesArray:qq] Platform:(UMSocialPlatformType_QQ)];
}

/*微信注册平台*/
-(void)setupWeChatWithAppId:(NSString*)appid{
    
    NSAssert(appid, @"微信平台初始化ID为空");

    if (!appid) {
        return;
    }
    
    [WXApi registerApp:appid];
    
    NSArray * weixin = @[
        @{
            @"platform_name":@"微信好友",
            @"icon_image":@"Group_wechatSession",
            @"plat_tag":@(UMSocialPlatformType_WechatSession)
                    },
                     @{
            @"platform_name":@"朋友圈",
            @"icon_image":@"Group_wechatTimeLine",
            @"plat_tag":@(UMSocialPlatformType_WechatTimeLine)
                     },@{
            @"platform_name":@"微信收藏",
            @"icon_image":@"Group_wechatFavorite",
            @"plat_tag":@(UMSocialPlatformType_WechatFavorite)
                     }
                ];
    [self addPlatformInfo:[GMPlatformModel mj_objectArrayWithKeyValuesArray:weixin] Platform:(UMSocialPlatformType_WechatSession)];
}

#pragma mark 添加平台信息
-(void)addPlatformInfo:(id)platformModel Platform:(UMSocialPlatformType)platformType {
    
    if (![[UMSocialManager defaultManager]isInstall:platformType]) {
        //没有安装平台
        return;
    }
    
    //没有平台信息
    if (!platformModel) {
        return;
    }
    
    pthread_mutex_lock(&_lock);
    if ([platformModel isKindOfClass:[NSArray class]]) {
        [platformModel enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                [self.platforms addObject:obj];
        }];
    }
    pthread_mutex_unlock(&_lock);
}
@end
