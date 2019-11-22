//
//  GMShareConfig.h
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import <Foundation/Foundation.h>
#import "GMConstHeader.h"


NS_ASSUME_NONNULL_BEGIN

@interface GMShareConfig : NSObject
/*分享渠道*/
@property(nonatomic,copy)NSString * channel;
/*小程序的测试类型*/
@property(nonatomic,assign)GMShareWXMiniProgramType  miniProgramType;

@end

NS_ASSUME_NONNULL_END
