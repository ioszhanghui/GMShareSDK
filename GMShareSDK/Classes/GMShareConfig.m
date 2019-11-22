//
//  GMShareConfig.m
//  FBSnapshotTestCase
//
//  Created by 小飞鸟 on 2019/11/20.
//

#import "GMShareConfig.h"

@implementation GMShareConfig

-(instancetype)init{
    if (self=[super init]) {
        
        _channel = @"AppStore"; //渠道 默认为 AppStore
#if Debug
        _miniProgramType = GMShareWXMiniProgramTypeTest;
#else
        _miniProgramType = GMShareWXMiniProgramTypeRelease;
#endif
    }
    return self;
}

@end
