//
//  GMPlatformModel.h
//  GMShareSDK
//
//  Created by 小飞鸟 on 2019/11/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GMPlatformModel : NSObject
/*平台名字*/
@property(nonatomic,copy)NSString * platform_name;
/*平台的icon*/
@property(nonatomic,copy)NSString * icon_image;
/*平台的 tag*/
@property(nonatomic,copy)NSString * plat_tag;


@end

NS_ASSUME_NONNULL_END
