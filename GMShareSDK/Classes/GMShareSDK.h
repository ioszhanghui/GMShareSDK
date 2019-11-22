//
//  GMShareSDK.h
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import <Foundation/Foundation.h>
#import "GMConstHeader.h"


@class GMSSDKRegister;
@class GMShareConfig;

typedef void(^GMShareStateChangedHandler)(id _Nullable data,NSError * _Nullable error);//分享结果回调

NS_ASSUME_NONNULL_BEGIN

@interface GMShareSDK : NSObject

/**
初始化
@param appKey UM的APPKEY
@param platformsRegister  平台注册
@param config 其他配置参数
*/

+(void)registerApp:(NSString*)appKey Platforms:(void(^)(GMSSDKRegister * platformsRegister))platformsRegister   Config:(GMShareConfig*)config;

/**
 *  打开日志
 *
 *  @param isOpen YES代表打开，No代表关闭
 */
+(void) openLog:(BOOL)isOpen;
/**
 分享内容
 @param parameters 分享参数
 @param stateChangedHandler 状态变更回调处理
 */
+ (void)shareWithParameters:(NSMutableDictionary *)parameters
        onStateChanged:(GMShareStateChangedHandler)stateChangedHandler;

@end

NS_ASSUME_NONNULL_END
