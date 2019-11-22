//
//  GMShareSDK.m
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import "GMShareSDK.h"
#import "GMShareConfig.h"
#import "GMSSDKRegister.h"

#import "NSDictionary+ShareCategory.h"
#import <UMShare/UMShare.h>
#import <UMCommon/UMCommon.h>

//#import "GMShareView.h"
#import "GMShareView.h"

@interface GMShareSDK ()
/*平台 注册*/
@property(nonatomic,strong)GMSSDKRegister * platformRegisterObj;
/*打开 日志打印*/
@property(nonatomic,assign)BOOL openLog;
/*配置*/
@property(nonatomic,strong)GMShareConfig * config;

@end

@implementation GMShareSDK

-(instancetype)init{
    if (self=[super init]) {
#ifdef DEBUG
        _openLog = YES;
#else
         _openLog = NO;
#endif
        
    }
    return self;
}

+(instancetype)shareSDK{
    static dispatch_once_t onceToken;
    static GMShareSDK * shareSDK;
    dispatch_once(&onceToken, ^{
        shareSDK = [GMShareSDK new];
    });
    return shareSDK;
}
+(void)registerApp:(NSString*)appKey Platforms:(void(^)(GMSSDKRegister * platformsRegister))platformsRegister   Config:(GMShareConfig*)config{
    //友盟
    [UMConfigure initWithAppkey:appKey channel:config.channel? config.channel:@"App Store"];
    GMShareSDK * shareSdk =[GMShareSDK shareSDK];
    GMSSDKRegister * registerObj = [[GMSSDKRegister alloc]init];
    shareSdk.platformRegisterObj = registerObj;
    shareSdk.config = config;
    platformsRegister(registerObj);
}

/**
 分享内容
 @param parameters 分享参数
 @param stateChangedHandler 状态变更回调处理
 */
+ (void)shareWithParameters:(NSMutableDictionary *)parameters
             onStateChanged:(GMShareStateChangedHandler)stateChangedHandler{
    
    NSAssert(parameters, @"缺少分享参数");
    if (!parameters) {
        return;
    }

    GMShareSDK * shareSdk = [GMShareSDK shareSDK];
    UIViewController * vc = [[GMShareSDK shareSDK] getCurrentViewController];
    if (shareSdk.openLog)  NSLog(@"%s----%d---%@",__func__,__LINE__,parameters);
    
    UMSocialMessageObject *messageObject = [parameters getShareObjWithConfig:shareSdk.config];
    
    [GMShareView showShareMenuViewInWindowWithPlatform:shareSdk.platformRegisterObj.platformsInfo SelectionBlock:^(GMSharePlatformType type) {
        //调用分享接口
        #pragma clang diagnostic push
        #pragma clang diagnostic ignored "-Wincompatible-pointer-types"
        [[UMSocialManager defaultManager] shareToPlatform:type messageObject:messageObject currentViewController:vc completion:^(id data, NSError *error) {
             //分享的回调信息
             if (stateChangedHandler) {
                 stateChangedHandler(data,error);
             }
            if (shareSdk.openLog)  NSLog(@"%s----%d---%@",__func__,__LINE__,error)
         }];
        #pragma clang diagnostic pop
    }];
}

/**
 *  打开日志
 *
 *  @param isOpen YES代表打开，No代表关闭
 */
+(void) openLog:(BOOL)isOpen{
     GMShareSDK * shareSdk = [GMShareSDK shareSDK];
    shareSdk.openLog = isOpen;
}


/*获取当前控制器*/
-(UIViewController *)getCurrentViewController{
    UIViewController * rootViewController = [self getApplicationDelegate].window.rootViewController;
    return [self getCurrentControllerFrom:rootViewController];
}

/*从一个控制器 当中拿到当前控制器啊*/
-(UIViewController*)getCurrentControllerFrom:(UIViewController*)viewController{
    
    if([viewController isKindOfClass:[UINavigationController class]]){
        //如果是导航控制器
        UINavigationController * nviController = (UINavigationController*)viewController;
        return [nviController.viewControllers lastObject];
    }else if ([viewController isKindOfClass:[UITabBarController class]]){
        //如果当前控制器是 Tabbar
        UITabBarController * tabbarController =(UITabBarController*)viewController;
        return [self getCurrentControllerFrom:tabbarController.selectedViewController];
    }else if (viewController.presentedViewController != nil){
        //如果当前是 普通的控制器
        return [self getCurrentControllerFrom:viewController.presentedViewController];
    }
    return viewController;
}


-(id<UIApplicationDelegate>)getApplicationDelegate{
    return [UIApplication sharedApplication].delegate;
}

@end
