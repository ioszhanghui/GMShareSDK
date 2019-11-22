//
//  GMSSDKRegister.h
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMSSDKRegister : NSObject

/*平台信息类*/
@property(nonatomic,strong,readonly)NSArray * platformsInfo;
/*微信注册平台*/
-(void)setupWeChatWithAppId:(NSString*)appid;
/*注册*/

/*QQ注册平台*/
-(void)setupWeChatWithAppId:(NSString*)appKey appSecret:(NSString*)appSecret;

@end

NS_ASSUME_NONNULL_END
