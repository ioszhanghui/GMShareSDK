//
//  NSDictionary+ShareCategory.h
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import <Foundation/Foundation.h>

@class UMSocialMessageObject;
@class GMShareConfig;

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (ShareCategory)
/*从 参数中 获取 分享对象*/
-(UMSocialMessageObject*)getShareObjWithConfig:(GMShareConfig*)config;
@end

NS_ASSUME_NONNULL_END
